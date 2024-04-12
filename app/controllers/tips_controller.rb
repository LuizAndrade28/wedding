class TipsController < ApplicationController
  before_action :set_tip, only: %i[edit update destroy]
  before_action :set_wedding, only: %i[new create edit update]

  def new
    @tip = Tip.new
  end

  def create
    @tip = Tip.new(tip_params)
    @tip.wedding = @wedding

    respond_to do |format|
      if params[:save_and_create_tip].present? && @tip.save
        format.html { redirect_to new_wedding_tip_path(@wedding), notice: 'Dica criada com sucesso.' }
      elsif params[:save_and_return].present? && @tip.save
        format.html { redirect_to user_profile_path(current_user), notice: 'Dica criada com sucesso.' }
      else
        format.html { render :new }
      end
    end
  end

  def edit
  end

  def update
    if @tip.update(tip_params)
      redirect_to user_profile_path(current_user)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @tip.destroy
    redirect_to user_profile_path(current_user)
  end

  private

  def set_wedding
    @my = Wedding.last
    @wedding = Wedding.find(@my.id)
  end

  def set_tip
    @tip = Tip.find(params[:id])
  end

  def tip_params
    params.require(:tip).permit(:title, :content)
  end
end
