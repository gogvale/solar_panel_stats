class GetPowerGenerationJob < ApplicationJob
  queue_as :default

  def perform(*args)
    response = HTTParty.get(Figaro.env.solar_panel_address,
                            basic_auth: { username: Figaro.env.solar_panel_username,
                                          password: Figaro.env.solar_panel_password })
    server_values = Nokogiri::HTML(response).xpath("/html/head/script[2]/text()").first.to_s
    Measurement.create(
      {
        current_power: strip(server_values[/webdata_now_p .+/]),
        yield_today: strip(server_values[/webdata_today_e .+/]),
        total_yield: strip(server_values[/webdata_total_e .+/]),
        alert: strip(server_values[/webdata_alarm .+/]),
      }.compact_blank
    )
  end

  private

  def strip(string)
    # string[/\d+(.\d+)?+/]
    string.split("\"").second
  end
end
