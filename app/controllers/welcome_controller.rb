# frozen_string_literal: true

class WelcomeController < ApplicationController
  def index
    @google_maps_url = 'https://maps.app.goo.gl/UZTW22MfQMZWa6mQ6'
  end

  def process_payment
    # validar os parametros
    if params[:identification_type].blank? ||
      params[:identification_number].blank? ||
      params[:amount].blank? ||
      params[:email].blank?
      @error = true
      return
    end
    #criar o pagamento
    response = MercadopagoService.new(params).call
    if response.has_key?('error')
      @api_error = true
    end
    #mostrar qr code e codigo copia e cola na tela (js)
    @qr_code_base64 = response['point_of_interaction']['transaction_data']['qr_code_base64']
    @qr_code        = response['point_of_interaction']['transaction_data']['qr_code']
    @ticket_url     = response['point_of_interaction']['transaction_data']['ticket_url']
  end
end
