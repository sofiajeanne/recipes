require 'rubygems'
require 'sqlite3'

# DBNAME = "recipes.sqlite"
# File.delete(DBNAME) if File.exists?DBNAME

# DB = SQLite3::Database.new( DBNAME )
# DB = "recipes.sqlite"
# DB.execute("CREATE TABLE recipe(recipe_id INTEGER PRIMARY KEY, recipe_name TEXT, instructions TEXT)")
# DB.execute("CREATE TABLE ingredients(ing_id INTEGER PRIMARY KEY, ing TEXT)")
# DB.execute("CREATE TABLE recipe_ing_rel(recipe_id INT, ing_id INT, amount REAL, unit TEXT)")

# DB = SQLite3::Database.open "recipes.sqlite"
# DB.execute "INSERT INTO recipe VALUES(1, 'Korean Cucumber Salad')"


DB = SQLite3::Database.open (File.expand_path('../recipes.sqlite', __FILE__))

class Recipe

  def recipe_name
    puts "Enter recipe name"
    recipe_name = $stdin.gets.chomp
    @recipe_name = recipe_name
  end

  def recipe_ingredients
    @ingredients = []
    loop do
      puts "Enter all ingredients, then type 'done'"
      ingredient = $stdin.gets.chomp
      @ingredients << ingredient
      break if ingredient == "done"
    end
    @ingredients.pop
    @ingredients.map! {|ingredient| ingredient.split}
    array.map do |element|
      full_ing = element[2].concat(" #{element[3]}")
      element.pop
    end
  end

    @ingredients
  end

  def recipe_instructions
    puts "Enter instructions"
    instructions = $stdin.gets.chomp
    @instructions = instructions
  end

  def add_recipe
    DB.execute "INSERT INTO recipes(recipe_id, recipe_name, instructions) VALUES(NULL, '#{@recipe_name}', '#{@instructions}')"
  end

  def add_ingredients
    @ingredients.each do |ingredient|
      DB.execute "INSERT INTO ingredients(ing_id, ing) VALUES(NULL, '#{ingredient[2]}')"
    end
  end

  def add_rels
  end

  end
  def run
    recipe_name
    recipe_ingredients
    recipe_instructions
    add_recipe
    add_ingredients
  end

end

=begin

open ingredients table
**iterate over array to check if ingredient exists in db
**return ingredients with matching words as potential matches
**  if there's a match, take ingredient_id
  elsif none match, insert 
    ingredient id (NULL)
    ingredient_name

open recipe_ing_rel table
for each ingredient insert
  recipe id (matched to recipe_name)
  ingredient id (matched to ing)
  amount
  unit
=end