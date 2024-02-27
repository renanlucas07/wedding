require 'mercadopago'
class MercadopagoService
  attr_accessor :sdk, :params

  def initialize(params)
    @sdk = Mercadopago::SDK.new(ENV['MP_ACCESS_TOKEN'])
    @params = params
  end

  def call
    custom_headers = {
      'x-idempotency-key' => params[:email]
    }
    
    custom_request_options = Mercadopago::RequestOptions.new(custom_headers: custom_headers)
    
    payment_request = {
      transaction_amount: params[:amount].to_f,
      description: params[:description],
      payment_method_id: 'pix',
      payer: {
        email: params[:email],
        identification: {
          type: params[:identification_type],
          number: params[:identification_number],
        }
      }
    }
    payment_response = sdk.payment.create(payment_request, request_options: custom_request_options)
    puts payment_response[:response]
    payment = payment_response[:response]
  end
end
