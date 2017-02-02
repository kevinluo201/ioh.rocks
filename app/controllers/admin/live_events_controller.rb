class Admin::LiveEventsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_admin

  def index
    @live_events = LiveEvent.all
  end

  def new
    @live_event = LiveEvent.new
  end

  def create
    @live_event = LiveEvent.new strong_params
    if @live_event.save
      flash[:success] = '新增成功'
      redirect_to admin_live_events_path
    else
      flash[:danger] = '新增失敗'
      render :new
    end
  end

  def edit
    @live_event = LiveEvent.find(params[:id])
  end

  def update
    # force there is only one active event
    LiveEvent.update_all active: false if strong_params[:active] == '1'

    @live_event = LiveEvent.find(params[:id])
    if @live_event.update strong_params
      flash[:success] = '修改成功'
      redirect_to admin_live_events_path
    else
      flash[:danger] = '修改失敗'
      render :edit
    end
  end

  def destroy
    @live_event = LiveEvent.find(params[:id])
    @live_event.destroy
    flash[:success] = '已刪除'
    redirect_to admin_live_events_path
  end

  private

  def check_admin
    if current_user.regular?
      redirect_to new_user_session_path
    end
  end

  def strong_params
    params.require(:live_event).permit(:start_date, :end_date, :signup_end, :active)
  end
end
