def sign_out!
  ApplicationController.class_eval <<-STRING
  def current_user
    nil
  end

  helper_method :current_user
  STRING
end

def sign_in!(options={})
  ApplicationController.class_eval <<-STRING
    def current_user
      Consumer.new(:consumer_id => "962", :first_name => "Eric", :zip_code => "66062", :email => Identifier.new(:type_id => "email", :value =>"ebudd@zavers.com", :id => 2544))
    end

    helper_method :current_user
    STRING
end
