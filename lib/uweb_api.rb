class UwebApi < MadridApi

  def client
    @client = Savon.client(wsdl: Rails.application.secrets.uweb_api_endpoint, encoding: 'ISO-8859-1')
  end

  def request(params)
    h=Hash.new
    h[:appKey] = Rails.application.secrets.uweb_api_app_key
    params.each do |k,v|
      h[k] = v
    end
    {request: h}
  end

  def get_users(profileKey)
    data = data(:get_users_profile_application_list,{profileKey: profileKey})
    Hash.from_xml(data)['USUARIOS']['USUARIO']
  end

  def get_user(userKey)
    data = data(:get_user_data, {userKey: userKey})
    data = data.encode('ISO-8859-1')
    Hash.from_xml(data)['USUARIO']
  end

  def get_application_status
    data = data(:get_application_data, {})
    Hash.from_xml(data)['APLICACION']['BLOQ_APLIC'].to_i
  end

  def get_user_status(userKey, date)
    data = data(:get_status_user_data,{userKey: userKey,date: date})
    Hash.from_xml(data)['USUARIO']['BAJA_LOGICA'].to_i
  end

end
