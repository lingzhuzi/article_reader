require 'test_helper'

class ReaderConfigsControllerTest < ActionController::TestCase
  setup do
    @reader_config = reader_configs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:reader_configs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create reader_config" do
    assert_difference('ReaderConfig.count') do
      post :create, reader_config: { artical_content_selector: @reader_config.artical_content_selector, artical_next_page_content: @reader_config.artical_next_page_content, artical_next_page_selectors: @reader_config.artical_next_page_selectors, index_artical_link_selector: @reader_config.index_artical_link_selector, index_next_page_content: @reader_config.index_next_page_content, index_next_page_selector: @reader_config.index_next_page_selector, index_pages: @reader_config.index_pages, index_url: @reader_config.index_url, name: @reader_config.name }
    end

    assert_redirected_to reader_config_path(assigns(:reader_config))
  end

  test "should show reader_config" do
    get :show, id: @reader_config
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @reader_config
    assert_response :success
  end

  test "should update reader_config" do
    patch :update, id: @reader_config, reader_config: { artical_content_selector: @reader_config.artical_content_selector, artical_next_page_content: @reader_config.artical_next_page_content, artical_next_page_selectors: @reader_config.artical_next_page_selectors, index_artical_link_selector: @reader_config.index_artical_link_selector, index_next_page_content: @reader_config.index_next_page_content, index_next_page_selector: @reader_config.index_next_page_selector, index_pages: @reader_config.index_pages, index_url: @reader_config.index_url, name: @reader_config.name }
    assert_redirected_to reader_config_path(assigns(:reader_config))
  end

  test "should destroy reader_config" do
    assert_difference('ReaderConfig.count', -1) do
      delete :destroy, id: @reader_config
    end

    assert_redirected_to reader_configs_path
  end
end
