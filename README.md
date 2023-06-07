# Instructions

Powered by
https://www.youtube.com/watch?v=60wMhP7V1Po

## Creating a project with tailwind

```
rails new video_idea --css=tailwind  -T
```

## Apply style for the application

```
<main class="mx-auto py-20 container">
  <%=yield %>
</main>
```

## Appling top navigation

```
<nav class="bg-gray-200 fixed top-0 left-0 w-full flex justify-between items-center p-4">
  <ul class="flex">
    <li class="mr-4"><a href="#" class="text-gray-800 hover:text-gray-600">Link 1</a></li>
    <li class="mr-4"><a href="#" class="text-gray-800 hover:text-gray-600">Link 2</a></li>
  </ul>
  <div class="flex items-center">
    <input type="text" placeholder="Search" class="px-4 py-2 border border-gray-400 rounded-lg">
    <button type="submit" class="ml-4 px-4 py-2 bg-blue-500 text-white rounded-lg">Search</button>
  </div>
</nav>

```

and add to application
```
<%= render 'shared/header' %>
<main class="mx-auto py-20 container">
  <%=yield %>
</main>
```

## Generating pages
```
rails g controller pages home about videos
```

## And apply the routes

```
get 'about', to: 'pages#about'
get 'videos', to: 'pages#videos'
root "pages#home"
```

## Give some texts for each page

### For the home page
```
<h2 class="text-3xl font-bold mb-4">Welcome to my Video Search App! 🎥🔍</h2>

<div class="flex flex-col space-y-4">
  <div class="flex items-center">
    <span class="text-2xl mr-2">🔍</span>
    <p class="text-lg">Fast and Easy Search</p>
  </div>

  <div class="flex items-center">
    <span class="text-2xl mr-2">🎉</span>
    <p class="text-lg">Discover Amazing Content</p>
  </div>

  <div class="flex items-center">
    <span class="text-2xl mr-2">📚</span>
    <p class="text-lg">Extensive Video Library</p>
  </div>

  <div class="flex items-center">
    <span class="text-2xl mr-2">🌟</span>
    <p class="text-lg">Personalized Recommendations</p>
  </div>
</div>
```

### For the about page

```
<h2 class="text-3xl font-bold mb-4">About Our Video Search App 📽️🔍</h2>

<div class="flex flex-col space-y-4">
  <div class="flex items-center">
    <span class="text-2xl mr-2">🌟</span>
    <p class="text-lg">Our Mission ✨</p>
  </div>
  <p class="text-gray-700">
    At VideoSearch, our mission is to provide a seamless video search experience for users around the world. We aim to make finding and discovering videos a joyous and effortless process.
  </p>

  <div class="flex items-center">
    <span class="text-2xl mr-2">🚀</span>
    <p class="text-lg">Our Vision 🌌</p>
  </div>
  <p class="text-gray-700">
    We envision a world where people can easily explore an extensive collection of videos, connect with diverse content, and uncover new perspectives. We strive to be a trusted platform that empowers users to discover captivating videos that align with their interests and preferences.
  </p>

  <div class="flex items-center">
    <span class="text-2xl mr-2">💡</span>
    <p class="text-lg">Innovation & Quality ⚡</p>
  </div>
  <p class="text-gray-700">
    Innovation and quality are at the core of what we do. We continuously improve our search algorithms, user experience, and recommendation systems to ensure our users receive the best video search results and personalized recommendations.
  </p>
</div>
```

### For the video search page

```
<h2 class="text-3xl font-bold mb-4">Search Results for "Term" 🔎📺</h2>

<ul class="space-y-4">
  <li>
    <div class="border border-gray-200 p-4">
      <h3 class="top-0 left-0 w-full bg-white text-gray-800 font-bold py-2 z-10">Video Result 1</h3>
      <a href="video-url-1" class="text-blue-500 hover:underline block mt-8">View Video</a>
    </div>
  </li>
  <li>
    <div class="border border-gray-200 p-4">
      <h3 class="top-0 left-0 w-full bg-white text-gray-800 font-bold py-2 z-10">Video Result 2</h3>
      <a href="video-url-2" class="text-blue-500 hover:underline block mt-8">View Video</a>
    </div>
  </li>
  <li>
    <div class="border border-gray-200 p-4">
      <h3 class="top-0 left-0 w-full bg-white text-gray-800 font-bold py-2 z-10">Video Result 3</h3>
      <a href="video-url-3" class="text-blue-500 hover:underline block mt-8">View Video</a>
    </div>
  </li>
</ul>
```

## Changing the form to rails code
```
<%= form_with url: videos_path, method: :get, class: "flex items-center" do |form| %>
  <%= form.text_field :query, value: params[:query],placeholder: "Search", class: "px-4 py-2 border border-gray-400 rounded-lg" %>
  <%= form.submit "Search", class: "ml-4 px-4 py-2 bg-blue-500 text-white rounded-lg" %>
<% end %>
```

## Apply links to header

```
<ul class="flex">
  <li class="mr-4"><%= link_to "Home", root_path(query: params[:query]), class: "text-gray-800 hover:text-gray-600" %></li>
  <li class="mr-4"><%= link_to "About", about_path(query: params[:query]), class: "text-gray-800 hover:text-gray-600" %></li>
</ul>
```

## Now it's time to generate video model

First add `faker gem`

```
bundle add faker
```

Generate the video model

```
rails g model Video title url
rails db:migrate
```

Add some data to seeds
```
10.times do
  Video.create!(title: Faker::Lorem.sentence, url: Faker::Internet.url)
end
```

and add to database
```
rails db:seed
```

## Changing the videos page
First in the controller
```
def videos
  @videos = Video.all
end
```

And now in the videos.erb.html file

```
<h2 class="text-3xl font-bold mb-4">Search Results for "<%=params[:query]%>" 🔎📺</h2>

<ul class="space-y-4">
  <% @videos.each do |video| %>
  <li>
    <div class="border border-gray-200 p-4">
      <h3 class="top-0 left-0 w-full bg-white text-gray-800 font-bold py-2 z-10"><%=video.title%></h3>
      <%= link_to video.url, class: "text-blue-500 hover:underline block mt-8" do %>
        <%= video.url %>
      <% end %>
    </div>
  </li>
  <% end %>
</ul>

```

## The old way of doing

In the controller we add the following code

```
def videos
  @videos = if params[:query].empty?
              Video.all
            else
              Video.where('title like ?', "%#{params[:query]}%")
            end
end
```

## The new way of doing

First we need to persist the code inside the form and between pages with the code

in the _header, remove params and add permanent
```
<%= form.text_field :query, placeholder: "Search", class: "px-4 py-2 border border-gray-400 rounded-lg", data: {turbo: 'permanent'} %>
```

in the _header, we need to involve the form_with with turbo_frame_tag

```
<%= turbo_frame_tag 'navbar' do %>
  <%= form_with url: videos_path, method: :get, class: "flex items-center" do |form| %>
  <!-- ... -->
<% end %>
```

and for each page add the following code
```
<%= turbo_frame_tag 'navbar' %>
```

And let's the magic in form_with
- add id
- add
```
data: {turbo_permanent: true}
```
and remove the turbo: 'permanent' in the input


the final code will be
```
<%= form_with url: videos_path,  method: :get, class: "flex items-center", id: 'search-videos', data: {turbo_frame: "_top", turbo_permanent: true} do |form| %>
  <%= form.text_field :query, placeholder: "Search", class: "px-4 py-2 border border-gray-400 rounded-lg" %>
  <%= form.submit "Search", class: "ml-4 px-4 py-2 bg-blue-500 text-white rounded-lg" %>
<% end %>
```