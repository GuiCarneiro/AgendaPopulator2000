require './lib/headquarters.rb'
require './lib/classrooms.rb'
require './lib/disciplines.rb'
require './lib/students.rb'
require './lib/responsibles.rb'
require './lib/teachers.rb'
require './lib/team.rb'
require './lib/autentication.rb'

puts 'Qual a URL do Staging?'
SCHOOL_URL = gets.chomp

puts 'Qual o usuário ou e-mail do SchoolUser?'
SCHOOL_USERNAME = gets.chomp

puts 'Qual a Senha do SchoolUser?'
SCHOOL_PASSWORD = gets.chomp

puts 'Qual o token da escola?'
SCHOOL_TOKEN = gets.chomp

puts 'Qual o ID da Disciplina Polivalente?'
SCHOOL_FIRST_DISCIPLINE = gets.chomp


school_auth_token = AgendaAutentication.auth(
	SCHOOL_USERNAME,
	SCHOOL_PASSWORD,
	SCHOOL_URL,
	SCHOOL_TOKEN
)

printf("\rProgress: [%-20s]", "=" * (1))

headquarters = AgendaGenerateHeadquarters.generate(
	SCHOOL_URL,
	SCHOOL_TOKEN,
	school_auth_token
)

printf("\rProgress: [%-20s]", "=" * (2))

classrooms = AgendaGenerateClassrooms.generate(
	SCHOOL_URL,
	SCHOOL_TOKEN,
	school_auth_token,
	SCHOOL_FIRST_DISCIPLINE,
	headquarters
)

printf("\rProgress: [%-20s]", "=" * (3))

disciplines = AgendaGenerateDisciplines.generate(
	SCHOOL_URL,
	SCHOOL_TOKEN,
	school_auth_token,
	classrooms
)

printf("\rProgress: [%-20s]", "=" * (5))

students = AgendaGenerateStudents.generate(
	SCHOOL_URL,
	SCHOOL_TOKEN,
	school_auth_token,
	classrooms
)

printf("\rProgress: [%-20s]", "=" * (9))

responsibles = AgendaGenerateResponsibles.generate(
	SCHOOL_URL,
	SCHOOL_TOKEN,
	school_auth_token,
	students
)

printf("\rProgress: [%-20s]", "=" * (13))

teachers = AgendaGenerateTeachers.generate(
	SCHOOL_URL,
	SCHOOL_TOKEN,
	school_auth_token,
	classrooms,
	disciplines
)

printf("\rProgress: [%-20s]", "=" * (16))

teams = AgendaGenerateTeams.generate(
	SCHOOL_URL,
	SCHOOL_TOKEN,
	school_auth_token,
	headquarters
)

printf("\rProgress: [%-20s]", "=" * (20))