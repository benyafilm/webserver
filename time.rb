require 'sinatra'
require 'timezone'

get '/' do
	erb :form
end

post '/form' do
  city=params[:message]
  city_new=city.split(' ')
  if city_new[1]!=nil
  	city=city_new[0]+"_"+city_new[1]
  end

  array_time = Timezone::Zone.names #array of city timezones
  find_time = array_time.find{ |e| /#{city}/ =~ e}
  time_zone = Timezone::Zone.new :zone => find_time
	show=time_zone.time Time.now
	ret=show.to_s.split(' ')
	time=ret[1]
	split_time=time.to_s.split(':')

	hour=split_time[0]
	if hour.to_i>12
		num_hour=hour.to_i-12
		am_pm="PM"
	else
		num_hour=hour
		am_pm="AM"
	end
	min=split_time[1]
	
	"The current time in #{city} is #{num_hour.to_s}:#{min.to_s} #{am_pm}"
end



