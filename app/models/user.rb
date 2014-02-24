class User < ActiveRecord::Base
	before_save { self.email = email.downcase } #Перевод почты к нижнему регистру перед сохранением в БД
	#before_save { email.downcase! } # Альтернативная реализация before_save
	validates :name, presence: true , length: { maximum: 50}  #Проверка на наличие имени и длину(максиммум 50)
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
	validates :email, presence: true, format: {with: VALID_EMAIL_REGEX},
	uniqueness: { case_sensitive: false} # Проверка на наличие почты, соответствие формату,уникальность и нечуствительность к регистру
	
	
	has_secure_password
	validates :password, length: { minimum: 6}
end