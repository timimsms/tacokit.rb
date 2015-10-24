module Tacokit
  class Client
    module Lists
      # Retrieve a list by id
      #
      # @see https://developers.trello.com/advanced-reference/list#get-1-labels-idlabel-board
      def list(list_id, options = nil)
        get list_path(list_id), options
      end

      # Retrive a list's actions
      #
      # @see https://developers.trello.com/advanced-reference/list#get-1-lists-idlist-actions
      def list_actions(list_id, options = {})
        paginated_list_resource list_id, "actions", options
      end

      # Retrive a list's board
      #
      # @see https://developers.trello.com/advanced-reference/list#get-1-lists-idlist-board
      def list_board(list_id, options = {})
        list_resource list_id, "board", options
      end

      # Retrive a list's cards
      #
      # @see https://developers.trello.com/advanced-reference/list#get-1-lists-idlist-cards
      def list_cards(list_id, options = {})
        paginated_list_resource list_id, "cards", options
      end

      # Update a list's attributes
      #
      # @see https://developers.trello.com/advanced-reference/list#put-1-lists-idlis
      def update_list(list_id, options = {})
        put list_path(list_id), options
      end

      # Create a new list
      #
      # @see https://developers.trello.com/advanced-reference/list#post-1-lists
      def create_list(board_id, name, options = {})
        post "lists", options.merge(name: name, board_id: board_id)
      end

      # Archive all cards in a list
      #
      # @see https://developers.trello.com/advanced-reference/list#post-1-lists-idlist-moveallcards
      def archive_list_cards(list_id)
        post list_path(list_id, camp("archive_all_cards"))
      end

      # Move cards from one list to another
      #
      # @see https://developers.trello.com/advanced-reference/list#post-1-lists-idlist-moveallcards
      def move_list_cards(list_id, destination_list_id, board_id)
        post list_path(list_id, camp("move_all_cards")),
          list_id: destination_list_id, board_id: board_id
      end

      private

      def list_resource(list_id, resource, *paths)
        paths, options = extract_options(camp(resource), *paths)
        get list_path(list_id, *paths), options
      end

      def paginated_list_resource(list_id, resource, *paths)
        paths, options = extract_options(camp(resource), *paths)
        paginated_get list_path(list_id, *paths), options
      end

      def list_path(list_id, *paths)
        resource_path("lists", list_id, *paths)
      end
    end
  end
end
