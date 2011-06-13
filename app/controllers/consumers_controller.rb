class ConsumersController < ApplicationController
  def new
    @consumer = LocalConsumer.new
  end

  def create
    @consumer = LocalConsumer.new(params[:local_consumer])
    if @consumer.valid?
      Zavers.consumer_create(@consumer.to_hash)
      redirect_to login_path, :notice => "Consumer Account Created. Sign in Below."
    else
      flash.now.notice = @consumer.errors.full_messages.to_sentence
      render :new
    end

    rescue ZaversError => e
      redirect_to signup_path, :notice => e.message
  end

  def edit
    @consumer = Zavers.consumer_read({:type_id => "email", :id_value => current_user.email.value}).to_local
    current_user = @consumer

  rescue ZaversError => e
    reset_session
    redirect_to login_path, :notice => e.message
  end

  def update
    @consumer = LocalConsumer.new(params[:local_consumer])
    @consumer.password = "pass"  # Temporary Hack
    if @consumer.valid?
      @consumer.consumer_id = current_user.consumer_id
      updated_user = Zavers.consumer_update(@consumer.to_hash)
      self.current_user = updated_user
      redirect_to edit_consumer_path(current_user.consumer_id), :notice => "Consumer Account Updated"
    else
      flash.now.notice = @consumer.errors.full_messages.to_sentence
      render :edit
    end
    rescue ZaversError => e
     redirect_to edit_consumer_path(current_user.consumer_id), :notice => e.message
  end
end
