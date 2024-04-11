require "open-uri"

puts "Creating seeds"
sleep 1
puts "Setting everything ready"
sleep 1
# Destroy all records, before seed creation
User.destroy_all
Wedding.destroy_all
Gift.destroy_all
puts "All records destroyed"

# Create a new user and wedding
couple_photo = URI.open("https://res.cloudinary.com/dtadfvhck/image/upload/v1711468309/Projeto-wed/Foto_casal_bphjdp.jpg")
user_photo = URI.open("https://res.cloudinary.com/dtadfvhck/image/upload/v1712860967/Projeto-wed/Perfil_evkqnx.jpg")
user = User.new(
  email: "luiz@yahoo.com.br",
  password: "flamengo",
  first_name: "Luiz",
  last_name: "Andrade",
  phone: "21999999999"
)

user.photo.attach(io: user_photo, filename: "", content_type: "image/png")
user.save!

wedding = Wedding.new(
  welcome_message: "No site vocês encontrarão todas as informações sobre o nosso grande dia. Estamos muito felizes em compartilhar esse momento com vocês. Agradecemos por todo o carinho e apoio que temos recebido. Contamos com a presença de cada um de vocês para celebrar conosco. Beijos, Cecília e Luiz.",
  date: "Sat, 16 Nov 2024",
  address: "Rua Visconde de Pirajá, 339 - Ipanema, Rio de Janeiro - RJ, 20030-002",
  wedding_info: "A cerimônia será realizada na Igreja Nossa Senhora da Paz, no Leblon, às 16h. Pedimos que todos cheguem no horário e os padrinhos e madrinhas, com uma hora de atecedência, por favor. Logo após a cerimônia, os convidados podem seguir para o local da festa, que será no Copacabana Palace, às 19h30.",
  user_id: user.id,
  time: "Sat, 16 Nov 2024 16:00:00.000000000 UTC +00:00",
  partner_first_name: "Cecilia",
  partner_last_name: "Moreira"
)
wedding.couple_photo.attach(io: couple_photo, filename: "", content_type: "image/png")
wedding.save!

puts "User and Wedding created"

# Create Weddings tips
tip1 = Tip.new(
  title: "Trajes",
  content: "Para tornar este momento ainda mais memorável, gostaríamos de sugerir um código de vestimenta que complemente a elegância e a beleza deste evento único: o Traje Social Completo.",
  wedding_id: wedding.id
)
tip1.save!
tip2 = Tip.new(
  title: "Salão de Beleza",
  content: "SELECIONAMOS ALGUNS SALÕES DE BELEZA QUE FORAM BEM RECOMENDADOS PARA AQUELAS QUE DESEJAREM AGENDAR CABELO E/OU MAQUIAGEM: WERNER IPANEMA (21) 2137-8958; STUDIO LEBLON: (21) 99652-7627; FIL HAIR & EXPERIENCE: (21) 2523-6688. DE QUALQUER FORMA, FIQUEM SUPER À VONTADE PARA BUSCAR OUTRAS ALTERNATIVAS CONSIDERANDO A REGIÃO QUE DECIDIREM SE HOSPEDAR.",
  wedding_id: wedding.id
)
tip2.save!

# Create a list of gifts
gift_file1 = URI.open("https://res.cloudinary.com/dtadfvhck/image/upload/v1712860711/Gifts/Jantar_Romanticopg_f4xhy0.jpg")
gift_file2 = URI.open("https://res.cloudinary.com/dtadfvhck/image/upload/v1712860706/Gifts/Jantar_Copa_y0stle.jpg")
gift_file3 = URI.open("https://res.cloudinary.com/dtadfvhck/image/upload/v1712860702/Gifts/img_paris_nxz0ag.jpg")
gift_file4 = URI.open("https://res.cloudinary.com/dtadfvhck/image/upload/v1712860695/Gifts/img_balao_k8syut.jpg")
gift_file5 = URI.open("https://res.cloudinary.com/dtadfvhck/image/upload/v1712860714/Gifts/mergulho_com_os_Golfinhos_iugmjw.jpg")
gift_file6 = URI.open("https://res.cloudinary.com/dtadfvhck/image/upload/v1712860729/Gifts/Viagem_ldxyz1.jpg")
gift_file7 = URI.open("https://res.cloudinary.com/dtadfvhck/image/upload/v1712860688/Gifts/coliseu_pheeqk.jpg")
gift_file8 = URI.open("https://res.cloudinary.com/dtadfvhck/image/upload/v1712860685/Gifts/aluguel_carro_od2qjj.jpg")
gift_file9 = URI.open("https://res.cloudinary.com/dtadfvhck/image/upload/v1712860698/Gifts/img_maldivas_zyfllj.jpg")
gift_file10 = URI.open("https://res.cloudinary.com/dtadfvhck/image/upload/v1712860691/Gifts/img_arizona_wzebzr.jpg")
gift_file11 = URI.open("https://res.cloudinary.com/dtadfvhck/image/upload/v1712860726/Gifts/safari_zkbeaa.jpg")
gift_file12 = URI.open("https://res.cloudinary.com/dtadfvhck/image/upload/v1712860722/Gifts/presentes_ascaiq.jpg")
gift_file13 = URI.open("https://res.cloudinary.com/dtadfvhck/image/upload/v1712860718/Gifts/praia_paradisiaca_p5pt4m.jpg")

gift1 = Gift.new(title: "Jantar Romântico", category: "Jantar", value: 450, total_quota: 10, wedding_id: wedding.id)
gift1.photo.attach(io: gift_file1, filename: "", content_type: "image/png")
gift1.save!
gift2 = Gift.new(title: "Jantar no Copacabana Palace", category: "Jantar", value: 800, total_quota: 10, wedding_id: wedding.id)
gift2.photo.attach(io: gift_file2, filename: "", content_type: "image/png")
gift2.save!
gift3 = Gift.new(title: "Jantar em Paris", category: "Jantar", value: 1000, total_quota: 10, wedding_id: wedding.id)
gift3.photo.attach(io: gift_file3, filename: "", content_type: "image/png")
gift3.save!
gift4 = Gift.new(title: "Passeio de Balão", category: "Passeio", value: 750, total_quota: 10, wedding_id: wedding.id)
gift4.photo.attach(io: gift_file4, filename: "", content_type: "image/png")
gift4.save!
gift5 = Gift.new(title: "Mergulho com Golfinhos", category: "Passeio", value: 1200, total_quota: 10, wedding_id: wedding.id)
gift5.photo.attach(io: gift_file5, filename: "", content_type: "image/png")
gift5.save!
gift6 = Gift.new(title: "Passagem de lua de mel", category: "Viagem", value: 7000, total_quota: 10, wedding_id: wedding.id)
gift6.photo.attach(io: gift_file6, filename: "", content_type: "image/png")
gift6.save!
gift7 = Gift.new(title: "Passeio ao Coliseu", category: "Passeio", value: 1500, total_quota: 10, wedding_id: wedding.id)
gift7.photo.attach(io: gift_file7, filename: "", content_type: "image/png")
gift7.save!
gift8 = Gift.new(title: "Aluguel de carro", category: "Viagem", value: 2500, total_quota: 10, wedding_id: wedding.id)
gift8.photo.attach(io: gift_file8, filename: "", content_type: "image/png")
gift8.save!
gift9 = Gift.new(title: "Hospedagem em maldivas", category: "Viagem", value: 8500, total_quota: 10, wedding_id: wedding.id)
gift9.photo.attach(io: gift_file9, filename: "", content_type: "image/png")
gift9.save!
gift10 = Gift.new(title: "Hiking no Arizona", category: "Viagem", value: 5000, total_quota: 10, wedding_id: wedding.id)
gift10.photo.attach(io: gift_file10, filename: "", content_type: "image/png")
gift10.save!
gift11 = Gift.new(title: "Safari", category: "Viagem", value: 7999, total_quota: 10, wedding_id: wedding.id)
gift11.photo.attach(io: gift_file11, filename: "", content_type: "image/png")
gift11.save!
gift12 = Gift.new(title: "Presente ao casal", category: "Outros", value: 3500, total_quota: 10, wedding_id: wedding.id)
gift12.photo.attach(io: gift_file12, filename: "", content_type: "image/png")
gift12.save!
gift13 = Gift.new(title: "Passeio à Praia Paradisíaca", category: "Viagem", value: 1570, total_quota: 10, wedding_id: wedding.id)
gift13.photo.attach(io: gift_file13, filename: "", content_type: "image/png")
gift13.save!
puts "Gifts created"

# Create a list of guests with faker

# 100.times do
#   emails = ["@gmail.com", "@hotmail.com", "@yahoo.com.br"]
#   special_caracters = ["í", "ã", "ç", "é", "õ", "ú", "ê", "á", "ó", "í", "ô"]
#   full_name = "#{Faker::Name.first_name} #{Faker::Name.unique.last_name}"
#   first_name = full_name.downcase.split(" ").first
#   last_name = full_name.downcase.split(" ").last
#   name = "#{first_name}_#{last_name}"

#   if special_caracters.any? { |char| name.include?(char) }
#     name = name.gsub("í", "i").gsub("ã", "a").gsub("ç", "c").gsub("é", "e").gsub("õ", "o").gsub("ú", "u").gsub("ê", "e").gsub("á", "a").gsub("ó", "o").gsub("í", "i").gsub("ô", "o")
#   end
#   guest = Guest.new(
#     full_name: full_name,
#     email: "#{name.downcase}#{emails.sample}",
#     # phone: Faker::PhoneNumber.unique.cell_phone,
#     phone: Faker::PhoneNumber.extension(length: 11),
#     confirmed: [true, false, nil].sample,
#     wedding_id: wedding.id
#   )
#   guest.save!
# end
