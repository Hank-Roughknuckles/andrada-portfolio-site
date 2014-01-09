# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create( id:0, email: "asdf@asdf.com", password: "asdfasdf", password_confirmation: "asdfasdf" )

NavItem.create(id:0, link_1_name: "About Me", link_2_name: "Showreel", link_3_name: "Works", link_4_name: "Current Projects", link_5_name: "Contact")

AboutMeContent.create(id: 0, header: "Who I Am", description: "Lorem ipsum sit dolor amet", button_title: "Intro")
AboutMeContent.create(id: 1, header: "What I Do", description: "Lorem ipsum sit dolor amet", button_title: "Qualifications")
AboutMeContent.create(id: 2, header: "What I Love", description: "Lorem ipsum sit dolor amet", button_title: "Bio")

Showreel.create(id: 0, header: "My Showreel", description: "Lorem ipsum sit dolor amet", video_link: "https://vimeo.com/83571847")
