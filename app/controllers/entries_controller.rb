class EntriesController < ApplicationController
  before_action :set_entry, only: [:show, :edit, :update, :destroy]
  before_action :load_entry, only: :create

  load_and_authorize_resource

  # GET /entries
  # GET /entries.json
  def index
    @entries = current_user.entries.expenses
  end

  # GET /entries/1
  # GET /entries/1.json
  def show
  end

  def home
    @now = Time.now

    @expense_entries = current_user.entries.expenses.includes(:category).where("date >= ?", 30.days.ago)
    @income_entries = current_user.entries.income.where("date >= ?", 30.days.ago)
    @expenses_total = @expense_entries.to_a.sum &:amount
    @income_total = @income_entries.to_a.sum &:amount
    # @entries_by_category = @entries.group_by { |entry| entry.category.root }.sort_by { |category, entries| entries.to_a.sum &:amount }.reverse
    @expense_entries_by_category = @expense_entries.group_by { |entry| entry.category.root }.sort_by { |category, entries| entries.to_a.sum &:amount }.reverse
    # @entries_by_category = current_user.categories.roots
    # @entries_by_category.map do |category, entries|
      # entries.group_by { |entry| entry.category_id }
    # end

    # puts @entries_by_category

    @entry = Entry.new
    @categories = current_user.categories.recent

    @selected_currency = current_user.use_last_currency ? current_user.entries.first.currency : current_user.currency
  end

  def archive
    @entries_by_month = current_user.entries.group_by { |entry| entry.date.beginning_of_month }
  end

  def month
    @month = Time.new(params[:year], params[:month])

    @entries = current_user.entries.where("date >= ? AND date <= ?", @month.beginning_of_month, @month.end_of_month)
    @expense_entries = current_user.entries.expenses.where("date >= ? AND date <= ?", @month.beginning_of_month, @month.end_of_month)
    @income_entries = current_user.entries.income.where("date >= ? AND date <= ?", @month.beginning_of_month, @month.end_of_month)
    @expense_entries_by_category = @expense_entries.group_by { |entry| entry.category.root }.sort_by { |category, entries| entries.to_a.sum &:amount }.reverse
    @expenses_total = @expense_entries.to_a.sum &:amount
    @income_total = @income_entries.to_a.sum &:amount

    # calculate number of days based on whether this is the current month or not
    @days = ( @month.end_of_month == Time.now.end_of_month ) ? Time.now.day : @month.end_of_month.day

    @previous_page = archive_entries_path
  end

  def month_entries
    @month = Time.new(params[:year], params[:month])

    @entries = current_user.entries.where("date >= ? AND date <= ?", @month.beginning_of_month, @month.end_of_month)
    @entries_by_date = @entries.group_by { |entry| entry.date }

    @previous_page = month_entries_path
  end

  # GET /entries/new
  def new
    @entry = Entry.new
    @categories = current_user.categories
  end

  # GET /entries/1/edit
  def edit
    @categories = current_user.categories

    @selected_currency = @entry.currency

    @previous_page = month_entries_entries_path( @entry.date.year, @entry.date.month )
  end

  # POST /entries
  # POST /entries.json
  def create
    # @entry = Entry.new(entry_params)
    ep = entry_params

    if ( ep[:category_id] == nil && params[:new_category_name] != '' )
      new_category = current_user.categories.new(:name => params[:new_category_name])
      new_category.save

      ep[:category_id] = new_category.id

      p ep[:category_id]
    end

    @entry = current_user.entries.build(ep)

    respond_to do |format|
      if @entry.save
        format.html { redirect_to root_path, notice: 'Entry created, nice.' }
        format.json { render action: 'show', status: :created, location: root_path }
      else
        format.html { redirect_to root_path }
        format.json { render json: @entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /entries/1
  # PATCH/PUT /entries/1.json
  def update
    respond_to do |format|
      if @entry.update(entry_params)
        format.html { redirect_to edit_entry_path(@entry), notice: 'Entry updated, nice.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /entries/1
  # DELETE /entries/1.json
  def destroy
    @entry.destroy
    respond_to do |format|
      format.html { redirect_to root_path }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_entry
      @entry = Entry.find(params[:id])
    end

    # https://github.com/ryanb/cancan/issues/835
    def load_entry
      @entry = Entry.new(entry_params)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def entry_params
      params.require(:entry).permit(:user_id, :from_amount, :currency, :date, :category_id, :entry_type, :year, :month)
    end
end
