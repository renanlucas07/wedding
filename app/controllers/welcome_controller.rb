# frozen_string_literal: true

class WelcomeController < ApplicationController
  def index
    @google_maps_url = 'https://goo.gl/maps/nBAxNAsmPSS2'
  end

  def process_payment
    # validar os parametros
    
    #criar o pagamento
    response = MercadopagoService.new(params).call

    #mostrar qr code e codigo copia e cola na tela (js)
  end
end
