require "sinatra"
require_relative "random_name_pairing.rb" 

enable :sessions 

get '/' do #get comes from a page
	erb :first_page
end

post '/first_name' do
  first_name = params[:first_name]
  "First name here: #{first_name}"
  redirect '/get_random_names?first_name=' + first_name 
end

get '/get_random_names' do
	first_name = params[:first_name]
	"Now in get random names route:  #{first_name}."
	erb :get_random_names, locals: {first_name: first_name}
end

post '/get_random_names' do
	first_name = params[:first_name]
	# name1 = params[:name1]
	# name2 = params[:name2]
	# name3 = params[:name3]
	# name4 = params[:name4]
	# name5 = params[:name5]
	# name6 = params[:name6]
	array = params[:new_name] 
	p "name array #{array}"
	
	# array = [name1, name2, name3, name4, name5, name6]
 #    p "Let's see these six names: #{name1}, #{name2}, #{name3}, #{name4}, #{name5}, #{name6}"
	session[:name_array] = sample(array)
	p "#{session[:name_array]}" 
	session[:liked_pairs] = []
	redirect '/results?first_name=' + first_name 
end

get '/results' do
	first_name = params[:first_name]
    erb :results, locals:{first_name: first_name, pairs_array: session[:name_array]}
end

post '/check_name' do
	first_name = params[:first_name]
	session[:pairs] = params[:teams]
	
	p "this should be the picked pairs#{session[:pairs]}"
	temp_array = []
	session[:name_array].each do |name|
		temp_array.push(name.join(','))
	end
	session[:name_array] = temp_array 

	leftovers = []
 	session[:name_array].each do |pairs|
		if session[:pairs].include?(pairs) == false
			leftovers << pairs.split(',')
		else
			session[:liked_pairs] << pairs.split(',')
		end		
	end

		puts "this is leftovers #{leftovers}"
	session[:leftovers] = leftovers.flatten
		if session[:leftovers].length == 0
		redirect '/final_result?first_name='+ first_name
		else 
		   session[:name_array] = sample(session[:leftovers])
		   redirect '/results?first_name=' + first_name
		end
end

get "/final_result" do
	first_name = params[:first_name]
	p "here is my first name #{first_name}"
	erb :final_result, locals:{first_name: first_name, pairs: session[:liked_pairs]}
end

post '/start_over' do
	redirect '/'
end

# 	leftovers = []
# 		session[:name_array].each do |pairs|
# 		session[:pairs].each do |team|
# 			p "this is pairs#{pairs}"
# 			p "this is pairs class#{pairs.class}"
# 			p "this is team#{team}"
# 			p "this is team class#{team.class}"
# 			p "this is pairs join#{pairs.join}"
# 			if pairs.join(',') == team

# 				p "pairs#{pairs} matches #{team}"
# 			else leftovers << pairs 
# 			end
# 		end
# 	end
# 	session[:leftovers] = leftovers 
# 	redirect '/final_result?first_name=' + first_name 
# 	#redirect '/final_result?first_name=' + first_name + '&pairs=' + session[:pairs]
# end

# get "/final_result" do #post goes to a page
# 	first_name = params[:first_name]
# 	erb :final_result, locals:{first_name: first_name, pairs: session[:pairs]}
# end

# get "/name_redirect" do
# 	name = session[:name]
# 	erb :second_page, locals: {name: name}