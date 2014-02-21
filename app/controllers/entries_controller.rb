class EntriesController < ApplicationController
  before_action :set_entry, only: [:show, :edit, :update, :destroy]

  # GET /entries
  # GET /entries.json
  def index
    @entries = current_user.entries
  end

  # GET /entries/1
  # GET /entries/1.json
  def show
  end

  def home
    if current_user.nil?
      return redirect_to new_user_session_path
    end

    @now = Time.now

    @entries = current_user.entries.where("date >= ?", @now.beginning_of_month)
    @total = @entries.sum &:amount
    @entries_by_category = @entries.group_by { |entry| entry.root_category }.sort_by { |category, entries| entries.sum &:amount }.reverse

    # @entries_by_category.map do |category, entries|
      # entries.group_by { |entry| entry.category_id }
    # end

    # puts @entries_by_category

    @entry = Entry.new
    @categories = current_user.categories
  end

  def archive
    @entries_by_month = current_user.entries.group_by { |entry| entry.date.beginning_of_month }
  end

  def month
    time = Time.new(params[:year], params[:month])

    @entries = current_user.entries.where("date >= ? AND date <= ?", time.beginning_of_month, time.end_of_month)
    @entries_by_date = @entries.group_by { |entry| entry.date }
    @entries_by_category = @entries.group_by { |entry| entry.root_category }.sort_by { |category, entries| entries.sum &:amount }.reverse
  end

  # GET /entries/new
  def new
    @entry = Entry.new
    @categories = current_user.categories
  end

  # GET /entries/1/edit
  def edit
    @categories = current_user.categories
  end

  # POST /entries
  # POST /entries.json
  def create
    # @entry = Entry.new(entry_params)
    @entry = current_user.entries.build(entry_params)

    respond_to do |format|
      if @entry.save
        format.html { redirect_to root_path, notice: 'Entry was successfully created.' }
        format.json { render action: 'show', status: :created, location: root_path }
      else
        format.html { render action: 'new' }
        format.json { render json: @entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /entries/1
  # PATCH/PUT /entries/1.json
  def update
    respond_to do |format|
      if @entry.update(entry_params)
        format.html { redirect_to root_path, notice: 'Entry was successfully updated.' }
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

    # Never trust parameters from the scary internet, only allow the white list through.
    def entry_params
      params.require(:entry).permit(:user_id, :amount, :date, :category_id, :year, :month)
    end
end
