class ReaderConfigsController < ApplicationController
  before_action :set_reader_config, only: [:show, :edit, :update, :destroy, :run]

  # GET /reader_configs
  # GET /reader_configs.json
  def index
    @reader_configs = ReaderConfig.all
  end

  # GET /reader_configs/1
  # GET /reader_configs/1.json
  def show
  end

  # GET /reader_configs/new
  def new
    @reader_config = ReaderConfig.new
  end

  # GET /reader_configs/1/edit
  def edit
  end

  # POST /reader_configs
  # POST /reader_configs.json
  def create
    @reader_config = ReaderConfig.new(reader_config_params)

    respond_to do |format|
      if @reader_config.save
        format.html { redirect_to @reader_config, notice: 'Reader config was successfully created.' }
        format.json { render :show, status: :created, location: @reader_config }
      else
        format.html { render :new }
        format.json { render json: @reader_config.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reader_configs/1
  # PATCH/PUT /reader_configs/1.json
  def update
    respond_to do |format|
      if @reader_config.update(reader_config_params)
        format.html { redirect_to @reader_config, notice: 'Reader config was successfully updated.' }
        format.json { render :show, status: :ok, location: @reader_config }
      else
        format.html { render :edit }
        format.json { render json: @reader_config.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reader_configs/1
  # DELETE /reader_configs/1.json
  def destroy
    @reader_config.destroy
    respond_to do |format|
      format.html { redirect_to reader_configs_url, notice: 'Reader config was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  # POST
  def run
    job = ArticalReadJob.perform_later(@reader_config)
    Task.create(job_id: job.job_id, reader_config_id: @reader_config.id, status: Task::WAITING)

    respond_to do |format|
      format.html { redirect_to reader_configs_url, notice: '采集任务已添加' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reader_config
      @reader_config = ReaderConfig.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def reader_config_params
      params.require(:reader_config).permit(:name, :index_url, :index_pages, :index_next_page_selector, :index_next_page_content, :index_artical_link_selector,
       :artical_content_selectors, :artical_img_selectors, :artical_next_page_selector, :artical_next_page_content)
    end
end
