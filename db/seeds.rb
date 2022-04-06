# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require "json"
require "open-uri"

Recommendation.destroy_all
Movie.destroy_all
User.destroy_all

puts "creating users"
# je creer des users
valentine = User.create(nickname: "valou", email: "valentine.fouche@hotmail.fr", password: "qwerty")
alexandru = User.create(nickname: "alex", email: "alexandru.rebenciuc@hotmail.fr", password: "qwerty")
ingo = User.create(nickname: "ing", email: "ingo.knorr@hotmail.fr", password: "qwerty")
eva = User.create(nickname: "vavou", email: "eva.lampin@hotmail.fr", password: "qwerty")


puts "creating movies"
# je creer des movies
les_evades = Movie.create(title: "Les évadés", director: "Frank Darabont", image_url: "les-evades.jpeg", stream_options: "Stream")
le_parrain = Movie.create(title: "Le parrain", director: "Francis Ford Coppola", image_url: "le-parrain.webp", stream_options: "Stream")
dark_knight = Movie.create(title: "The Dark Knight : Le Chevalier noir", director: "Christopher Nolan", image_url: "dark-knight.jpeg", stream_options: "Stream")
douze_hommes = Movie.create(title: "12 Hommes en colère", director: "Sidney Lumet", image_url: "douze-hommes.jpeg", stream_options: "Stream")
schindler = Movie.create(title: "La liste de Schindler", director: "Steven Spielberg", image_url: "schindler.jpeg", stream_options: "Stream")

puts "creating movies with API"
# je cree tous les movies présents dans OMDB

url = "https://imdb-api.com/en/API/Top250Movies/k_7bqg1dif"
movies_serialized = URI.open(url).read
movies = JSON.parse(movies_serialized)
movies["items"].each do |movie|
  Movie.create(title: movie["title"], director: movie["crew"], image_url: movie["image"], stream_options: "pas de stream pour l'instant" )
end

puts "creating recommandations"
# je creer des recommandations
recommandation_val_1 = Recommendation.create(friend: "alex", comment: "film conseillé quand nous avons mangé de la socca à nice, film d'action pleins de suspense", searched: false, viewed: false, user_id: valentine.id, movie_id: dark_knight.id)

recommandation_val_2 = Recommendation.create(friend: "ing", comment: "film sur la seconde guerre mondial, attention un peu triste donc à ne pas regarder en cas de coup de blues", searched: false, viewed: false, user_id: valentine.id, movie_id: schindler.id)

recommandation_alex_3 = Recommendation.create(friend: "vavou", comment: "film avec pleins de mafieux, action garantie ! Ne pas regarder avec les enfants", searched: false, viewed: false, user_id: alexandru.id, movie_id: le_parrain.id)

recommandation_ing_4 = Recommendation.create(friend: "alex", comment: "Un grand classic qu'Alexandru m'a dit de ne pas louper !!!", searched: false, viewed: false, user_id: ingo.id, movie_id: les_evades.id)

recommandation_vavou_5 = Recommendation.create(friend: "valou", comment: "film d'epoque super top", searched: false, viewed: false, user_id: valentine.id, movie_id: douze_hommes.id)


puts "done"
