class ArticalsController < ApplicationController
  before_action :find_articals, only: [:index, :download]
  before_action :set_artical, only: [:show, :edit, :update, :destroy]

  # GET /articals
  # GET /articals.json
  def index
    @articals = @articals.paginate(:page => params[:page], :per_page => 30)
  end

  def download
    send_file generate_file(@articals)
  end

  # GET /articals/1
  # GET /articals/1.json
  def show
  end

  # GET /articals/new
  def new
    @artical = Artical.new
  end

  # GET /articals/1/edit
  def edit
  end

  # POST /articals
  # POST /articals.json
  def create
    @artical = Artical.new(artical_params)

    respond_to do |format|
      if @artical.save
        format.html { redirect_to @artical, notice: 'Artical was successfully created.' }
        format.json { render :show, status: :created, location: @artical }
      else
        format.html { render :new }
        format.json { render json: @artical.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /articals/1
  # PATCH/PUT /articals/1.json
  def update
    respond_to do |format|
      if @artical.update(artical_params)
        format.html { redirect_to @artical, notice: 'Artical was successfully updated.' }
        format.json { render :show, status: :ok, location: @artical }
      else
        format.html { render :edit }
        format.json { render json: @artical.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articals/1
  # DELETE /articals/1.json
  def destroy
    @artical.destroy
    respond_to do |format|
      format.html { redirect_to articals_url, notice: 'Artical was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_artical
      @artical = Artical.find(params[:id])
    end

    def search_params
      if params[:artical].present?
        params.require(:artical).permit(:title, :reader_config_id)
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def artical_params
      params.require(:artical).permit(:title, :url, :content, :reader_config_id, :images)
    end

    def find_articals
      conditions = search_params
      @artical = Artical.new(conditions)
      @articals = Artical.where('')
      if conditions
        if conditions[:title].present?
          conditions[:title].split(' ').each do |key_word|
            @articals = @articals.where("title like ?", "%#{key_word}%") if key_word.present?
          end
        end
        @articals = @articals.where(reader_config_id: conditions[:reader_config_id]) if conditions[:reader_config_id].present?
      end
    end

    def generate_file(articals)
      file_name = 'tmp/文章.txt'
      file = File.new(file_name, 'w')
      articals.each do  |artical|
        file.puts artical.title
        file.puts artical.content
        file.puts "*"*100
        file.puts "\n\n\n"
      end
      file.close
      file_name
    end
end
