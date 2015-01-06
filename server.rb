require 'pry'
require 'sinatra'
require 'active_record'
require 'date'
require 'mustache'
require './lib/connection.rb'
require './lib/class.rb'

#This will be the home page html '/' 
 get '/' do
 	

 	File.read('./views/directory.html')
 	topic_name = Topic.last(5)
 	topic_description = Topic.select(:description)

Mustache.render(File.read('./views/directory.html'),{
		name: topic_name[0][:name], description: topic_name[0][:description], date: topic_name[0][:date],
		name2: topic_name[1][:name], description2: topic_name[1][:description], date2: topic_name[1][:date],
		name3: topic_name[2][:name], description3: topic_name[2][:description], date3: topic_name[2][:date],
		name4: topic_name[3][:name], description4: topic_name[3][:description], date4: topic_name[3][:date],
		name5: topic_name[4][:name], description5: topic_name[3][:description], date5: topic_name[4][:date]
		})

end 

post '/' do

	name = params["name"]
	description = params["description"]
	date = params["date"]

	Topic.create(name: name, description: description, date: date)

	redirect '/'

end

get '/add_new_topic' do
	File.read('./views/new_topic_test.html')
end



get '/new/post' do
	File.read('./views/post_create.html')

 #    array = []

	# Topic.find_each do |name|
 # 	array.push(name.name)                                    
 # 	end    
topic_name = Topic.last(50) 
list_of_topics = []

topic_name.each do |name|
	list_of_topics.push(name.name)
end 

Mustache.render(File.read('./views/post_create.html'),{ name: list_of_topics})
		# name: topic_name[0][:name],
		# name2: topic_name[1][:name],
		# name3: topic_name[2][:name],
		# name4: topic_name[3][:name], 
		# })
end 

post '/post' do
	 topic = params["topic"] 
	 title = params["name"]
	 message = params["message"]
	 author = params["author"]
	 date = params["date"]
	 likes = 0

Post.create(cat_id: topic,title: title,message: message,author: author,date: date,likes: likes)


redirect '/'
end 

get '/categories' do
	all_topics = Topic.all.to_a
	all_topics_name = []
     
    all_topics.each do |name|
    	all_topics_name.push(name.name)
    end

	Mustache.render(File.read('./views/categories_all.html'),{ name: all_topics_name})

end

get '/:topic' do 
	finally=[]
	topic = params[:topic]
	topic_info = Post.where(cat_id: topic)

	topic_info.each do |list_of_post| 
		finally.push(list_of_post.message)
	end 


Mustache.render(File.read('./views/topic_page.html'), {info: finally})

end 

# File.read('house.html')

# name = params[:name]
# houses = House.find_by(name: name)


# Mustache.render(File.read('house.html'),{id: houses.id, name: houses.name, sigil_url: houses.sigil_url, region: houses.region})

# get '/:name' do 

# 	File.read('house.html')

# 	name = params[:name]

# 	houses = House.find_by(name: name)


# 	Mustache.render(File.read('house.html'),{id: houses.id, name: houses.name, sigil_url: houses.sigil_url, region: houses.region})

# end 