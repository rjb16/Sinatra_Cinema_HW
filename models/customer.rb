require_relative('../db/sql_runner')

class Customer
    
    attr_reader :id
    attr_accessor :name, :funds

    def initialize(options)
        @id = options['id'].to_i if options ['id']
        @name = options['name']
        @funds = options['funds']

    end

    def save()
        sql = "INSERT INTO customers (name, funds)
        VALUES ($1, $2)
        RETURNING id"
        values = [@name, @funds]
        customer = SqlRunner.run(sql, values).first
        @id = customer['id'].to_i
    end

    def update()
        sql = "UPDATE customers SET (name, funds) = ($1, $2)
        WHERE id = $3"
        values = [@name, @funds]
        SqlRunner.run(sql, values)
    end

    # I wasnt sure if we were supposed to create a delete by ID or delete everything function, so i did both
    
    def delete()
        sql = "DELETE FROM customers WHERE id = $1"
        values = [@id]
        SqlRunner.run(sql, values)
    end

    def self.delete_all()
        sql = "DELETE FROM customers"
        SqlRunner.run(sql)
    end

    def self.map_items(data)
        result = data.map{|customer| Customer.new(customer)}
        return result
    end

    # trying to see which customers are coming to see one film.
    def films()
        sql = "SELECT films.* FROM films INNER JOIN tickets ON tickets.film.id
        = films.id WHERE tickets.customer_id = $1"
        values =[@id]
        film_data = SqlRunner.run(sql, values)
        return Customer.map_items(film_data)
    end

    # Not sure about finding the remaining funds but this is what i tried
    def remaining_funds()
        sql = "SELECT SUM(film.price) FROM films
        INNER JOIN tickets
        ON tickets.film_id = films.id
        WHERE film_id = $1"
        values = [@id]
        price = SqlRunner.run(sql, values).first['sum'].to_i
        remaining_funds = @funds.to_i - price
        return remaining_funds
    end

    def number_of_tickets()
        sql = "SELECT * FROM tickets
        WHERE customer_id = $1"
        values = [@id]
        tickets = SqlRunner.run(sql,values)
        result = Ticket.map_items(tickets)
        return result.length
    end



    
    




end

