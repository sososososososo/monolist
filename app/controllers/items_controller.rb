class ItemsController < ApplicationController
  before_action :require_user_logged_in

  def new
    @items = []

    @keyword = params[:keyword]
    if @keyword
      
      results = RakutenWebService::Ichiba::Item.search({
        keyword: @keyword,
        imageFlag: 1,
        hits: 20,
      })

      results.each do |result|
        item = Item.find_or_initialize_by(read(result))
        @items << item
      end
      
      raise
    end
  end
  
  
  
  def items
    @items = []

    @keyword = params[:keyword]
    if @keyword
      results = RakutenWebService::Ichiba::Item.search({
        keyword: @keyword,
        imageFlag: 1,
        hits: 20,
      })#検索結果はここに代入する

      results.each do |result|
        # 扱い易いように Item としてインスタンスを作成する（保存はしない）
        item = Item.find_or_initialize_by(read(result))
        @items << current_user.want(item)
      end
    end
  end
  
  def hitems
    @items = []

    @keyword = params[:keyword]
    if @keyword
      results = RakutenWebService::Ichiba::Item.search({
        keyword: @keyword,
        imageFlag: 1,
        hits: 20,
      })#検索結果はここに代入する

      results.each do |result|
        # 扱い易いように Item としてインスタンスを作成する（保存はしない）
        item = Item.find_or_initialize_by(read(result))
        @items << current_user.have(item)
      end
    end
  end
  
  
end