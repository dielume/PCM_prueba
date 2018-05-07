# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

dishes = [{name: "Ceviche", photo: "ceviche.jpg", price: 35},
          {name: "Pollo a la brasa", photo: "pollo_a_la_brasa.jpg", price: 45},
          {name: "Picante de Cuy", photo: "picante_de_cuy.jpg", price: 43},
          {name: "Olluquito con charqui", photo: "olluquito_con_charqui.jpg", price: 35},
          {name: "Causa rellena", photo: "causa_rellena.jpg", price: 23},
          {name: "Lomo saltado", photo: "lomo_saltado.jpg", price: 40},
          {name: "Ají de gallina", photo: "aji_de_gallina.jpg", price: 35},
          {name: "Rocoto relleno", photo: "rocoto_relleno.jpg", price: 30},
          {name: "Papa a la huancaina", photo: "papa_a_la_huancaina.jpg", price: 23},
          {name: "Anticuchos", photo: "anticuchos.jpg", price: 30},
          {name: "Tacu tacu", photo: "tacu_tacu.jpg", price: 35},
          {name: "Cau cau", photo:"cau_cau.jpg", price: 30}]

@foods = dishes.map { |dish| Food.new(dish) }
@foods.each{ |food| food.save}
