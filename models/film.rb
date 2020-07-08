require_relative('../db/sql_runner')

class Film

    attr_reader :id
    attr_accessor :title, :price

    def initialize(options)
        @id = options['id'].to_i if options ['id']
        @title = options['title']
        @price = options['price']
    end
    
    
    def save()
        sql = "INSERT INTO films (title, price) VALUES ($1, $2)
        RETURNING id"
        values = [@title, @price]
        film = SqlRunner.run(sql, values).first
        @id = film['id'].to_i
    end

    def update()
        sql = "UPDATE films SET (title, price) = ($1, $2)
        RETURNING id"
        values = [@title, @price]
        SqlRunner.run(sql, values)
    end

    # I wasnt sure if we were supposed to create a delete by ID or delete everything function, so i did both
    
    def delete()
        sql = "DELETE FROM films WHERE id = $1"
        values = [@id]
        SqlRunner.run(sql, values)
    end

    def self.delete_all()
        sql = "DELETE FROM films"
        SqlRunner.run(sql)
    end

    # Trying to show which films a customer has booked to see
    def customers()
        sql = "SELECT customers.* FROM customers INNER JOIN tickets ON ticket.customer_id
        = customers.id WHERE tickets.film_id = $1"
        values =[@id]
        customer_data = SqlRunner.run(sql, values)
        return Customer.map_items(customer_data)
end


      def self.find_all()
        sql = "SELECT * FROM films"
        result = SqlRunner.run(sql)
        return self.map_items(result)
        
end

      def self.map_items(data)
        result = data.map{|film| Film.new(film)}
        return result
      end

       





end