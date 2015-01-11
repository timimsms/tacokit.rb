module Tacokit
  class Client

    # Methods for the Cards API
    #
    # @see https://trello.com/docs/api/card/index.html
    module Cards

      # Retrieve a card by id or shortlink
      #
      # @see https://trello.com/docs/api/card/index.html#get-1-cards-card-id-or-shortlink
      def card(card_id, options = nil)
        get card_path(card_id), options
      end

      # Retrieve a card's field
      #
      # @see https://trello.com/docs/api/card/index.html#get-1-cards-card-id-or-shortlink-field
      def card_field(card_id, field, options = nil)
        get card_path(card_id, camp(field)), options
      end

      # Retrieve card actions
      #
      # @see https://trello.com/docs/api/card/index.html#get-1-cards-card-id-or-shortlink-actions
      def card_actions(card_id, options = {})
        card_resource(card_id, 'actions', options)
      end

      # Retrieve card attachments
      #
      # @see https://trello.com/docs/api/card/index.html#get-1-cards-card-id-or-shortlink-attachments
      def attachments(card_id, options = {})
        card_resource(card_id, 'attachments', options)
      end
      alias card_attachments attachments

      # Retrieve a card attachment
      #
      # @see https://trello.com/docs/api/card/index.html#get-1-cards-card-id-or-shortlink-attachments-idattachment
      def attachment(card_id, attachment_id, options = {})
        card_resource(card_id, "attachments/#{attachment_id}", options)
      end

      # Retrieve a card board
      #
      # @see https://trello.com/docs/api/card/index.html#get-1-cards-card-id-or-shortlink-board
      def card_board(card_id, options = {})
        card_resource(card_id, 'board', options)
      end

      # Retrieve card checklist item states
      #
      # @see https://trello.com/docs/api/card/index.html#get-1-cards-card-id-or-shortlink-board
      def check_item_states(card_id, options = {})
        card_resource(card_id, 'check_item_states', options)
      end

      # Retrieve card checklists
      #
      # @see https://trello.com/docs/api/card/index.html#get-1-cards-card-id-or-shortlink-board
      def checklists(card_id, options = {})
        card_resource(card_id, 'checklists', options)
      end

      # Retrive a card list
      #
      # @see https://trello.com/docs/api/card/index.html#get-1-cards-card-id-or-shortlink-list
      def card_list(card_id, options = {})
        card_resource(card_id, 'list', options)
      end

      # Retrieve card members
      #
      # @see https://trello.com/docs/api/card/index.html#get-1-cards-card-id-or-shortlink-members
      def card_members(card_id, options = {})
        card_resource(card_id, 'members', options)
      end

      # Retrieve members who voted on a card
      #
      # @see https://trello.com/docs/api/card/index.html#get-1-cards-card-id-or-shortlink-membersvoted
      def card_members_voted(card_id, options = {})
        card_resource(card_id, 'members_voted', options)
      end

      # Retrieve card stickers
      #
      # @see https://trello.com/docs/api/card/index.html#get-1-cards-card-id-or-shortlink-stickers
      def stickers(card_id, options = {})
        card_resource(card_id, 'stickers', options)
      end

      # Retrieve any card resource
      def card_resource(card_id, resource, options = {})
        get card_path(card_id, camp(resource)), options
      end

      # Update card attributes
      #
      # @see https://trello.com/docs/api/card/index.html#put-1-cards-card-id-or-shortlink
      def update_card(card_id, options = {})
        put card_path(card_id), options
      end

      # Update comment text
      #
      # @see https://trello.com/docs/api/card/index.html#put-1-cards-card-id-or-shortlink-actions-idaction-comments
      def update_comment(card_id, comment_id, text, options = {})
        update_card_resource(card_id, 'actions', comment_id, 'comments', options.merge(text: text))
      end
      alias edit_comment update_comment

      # Update checklist item text, position or state
      #
      # @see https://trello.com/docs/api/card/index.html#put-1-cards-card-id-or-shortlink-checklist-idchecklistcurrent-checkitem-idcheckitem
      def update_check_item(card_id, checklist_id, check_item_id, options = {})
        update_card_resource(card_id, 'checklist', checklist_id, 'checkItem', check_item_id, options)
      end

      # Archive a card
      #
      # @see https://trello.com/docs/api/card/index.html#put-1-cards-card-id-or-shortlink-closed
      def archive_card(card_id)
        update_card(card_id, closed: true)
      end

      # Restore an archived card
      #
      # @see https://trello.com/docs/api/card/index.html#put-1-cards-card-id-or-shortlink-closed
      def restore_card(card_id)
        update_card(card_id, closed: false)
      end

      # Move card to another position, board and/or list
      #
      # @see https://trello.com/docs/api/card/index.html#put-1-cards-card-id-or-shortlink-idboard
      # @see https://trello.com/docs/api/card/index.html#put-1-cards-card-id-or-shortlink-idlist
      def move_card(card_id, options)
        unless options.is_a?(Hash) &&
          ([:board_id, :list_id, :pos].any? { |key| options.key? key })
          raise ArgumentError.new("Required option: :pos, :board_id and/or :list_id")
        end
        update_card(card_id, options)
      end

      # Update card name
      #
      # @see https://trello.com/docs/api/card/index.html#put-1-cards-card-id-or-shortlink-name
      def update_card_name(card_id, name)
        put card_path(card_id, 'name'), value: name
      end

      # Subscribe to card
      #
      # @see https://trello.com/docs/api/card/index.html#put-1-cards-card-id-or-shortlink-subscribed
      def subscribe_to_card(card_id)
        put card_path(card_id, 'subscribed'), value: true
      end

      # Unubscribe from card
      #
      # @see https://trello.com/docs/api/card/index.html#put-1-cards-card-id-or-shortlink-subscribed
      def unsubscribe_from_card(card_id)
        put card_path(card_id, 'subscribed'), value: false
      end

      # Update any card resource
      def update_card_resource(card_id, resource, *paths)
        paths, options = extract_options(camp(resource), *paths)
        put card_path(card_id, *paths), options
      end

      # Create a card
      #
      # @see https://trello.com/docs/api/card/index.html#post-1-cards
      def create_card(list_id, name = nil, options = {})
        post card_path, options.merge(name: name, list_id: list_id)
      end

      # Add a comment to a card
      #
      # @see https://trello.com/docs/api/card/index.html#post-1-cards-card-id-or-shortlink-actions-comments
      def add_comment(card_id, text, options = {})
        options.update text: text
        create_card_resource card_id, "actions", "comments", options
      end
      alias create_card_comment add_comment

      # Attach a file to a card
      #
      # @see https://trello.com/docs/api/card/index.html#post-1-cards-card-id-or-shortlink-attachments
      def attach_file(card_id, url, mime_type = nil, options = {})
        if mime_type.is_a?(Hash)
          options = mime_type
        end

        uri = Addressable::URI.parse(url)

        if uri.scheme =~ %r{https?}
          options.update url: uri.to_s, mime_type: mime_type
        else
          file = Faraday::UploadIO.new(uri.to_s, mime_type)
          options.update file: file, mime_type: file.content_type
        end

        create_card_resource card_id, 'attachments', options
      end
      alias create_card_attachment attach_file

      # Convert a checklist item to a card
      #
      # @see https://trello.com/docs/api/card/index.html#post-1-cards-card-id-or-shortlink-checklist-idchecklist-checkitem-idcheckitem-converttocard
      def convert_to_card(card_id, checklist_id, check_item_id)
        create_card_resource(card_id, 'checklist', checklist_id, 'checkItem', check_item_id, 'convertToCard')
      end

      # Add a checklist item to a checklist
      #
      # @see https://trello.com/docs/api/card/index.html#post-1-cards-card-id-or-shortlink-checklist-idchecklist-checkitem
      def add_checklist_item(card_id, checklist_id, name, options = {})
        create_card_resource(card_id, 'checklist', checklist_id, 'checkItem', options.merge(name: name))
      end

      # Start a new checklist on card
      #
      # @see https://trello.com/docs/api/card/index.html#post-1-cards-card-id-or-shortlink-checklists
      def start_checklist(card_id, name)
        create_card_resource(card_id, 'checklists', name: name)
      end
      alias create_card_checklist start_checklist

      # Copy another checklist to card
      #
      # @see https://trello.com/docs/api/card/index.html#post-1-cards-card-id-or-shortlink-checklists
      def copy_checklist(card_id, checklist_id)
        create_card_resource(card_id, 'checklists', checklist_source_id: checklist_id)
      end

      # Add a member to a card
      #
      # @see https://trello.com/docs/api/card/index.html#post-1-cards-card-id-or-shortlink-idmembers
      def add_member_to_card(card_id, member_id)
        create_card_resource(card_id, 'idMembers', value: member_id)
      end

      # Add label to card
      #
      # @see https://trello.com/docs/api/card/index.html#post-1-cards-card-id-or-shortlink-labels
      def add_label(card_id, color, options = {})
        create_card_resource(card_id, 'labels', options.merge(color: color))
      end

      # Cast vote for card
      #
      # @see https://trello.com/docs/api/card/index.html#post-1-cards-card-id-or-shortlink-membersvoted
      def vote(card_id, member_id)
        create_card_resource(card_id, 'membersVoted', value: member_id)
      end

      # Create a card resource
      #
      def create_card_resource(card_id, resource, *paths)
        paths, options = extract_options(camp(resource), *paths)
        post card_path(card_id, *paths), options
      end

      # DELETE cards/[card id or shortlink]
      #
      # @see https://trello.com/docs/api/card/index.html#delete-1-cards-card-id-or-shortlink
      def delete_card(card_id)
        delete card_path(card_id)
      end

      # Delete a comment
      #
      # @see https://trello.com/docs/api/card/index.html#post-1-cards-card-id-or-shortlink-labels
      def delete_comment(card_id, comment_id)
        delete_card_resource card_id, "actions", comment_id, "comments"
      end

      # Remove an attachment
      #
      # @see https://trello.com/docs/api/card/index.html#delete-1-cards-card-id-or-shortlink-attachments-idattachment
      def remove_attachment(card_id, attachment_id)
        delete_card_resource card_id, 'attachments', attachment_id
      end

      # Remove checklist
      #
      # @see https://trello.com/docs/api/card/index.html#delete-1-cards-card-id-or-shortlink-checklists-idchecklist
      def remove_checklist(card_id, checklist_id)
        delete_card_resource card_id, 'checklists', checklist_id
      end

      # Remove a member from a card
      #
      # @see https://trello.com/docs/api/card/index.html#delete-1-cards-card-id-or-shortlink-idmembers-idmember
      def remove_card_member(card_id, member_id)
        delete_card_resource card_id, 'idMembers', member_id
      end

      # Remove label from card
      #
      # @see https://trello.com/docs/api/card/index.html#delete-1-cards-card-id-or-shortlink-labels-color
      def remove_label(card_id, color)
        delete_card_resource card_id, 'labels', color
      end

      # Remove a vote from a card
      #
      # @see https://trello.com/docs/api/card/index.html#delete-1-cards-card-id-or-shortlink-membersvoted-idmember
      def remove_vote(card_id, member_id)
        delete_card_resource card_id, 'membersVoted', member_id
      end

      # Remove a sticker from a card
      #
      # @see https://trello.com/docs/api/card/index.html#delete-1-cards-card-id-or-shortlink-membersvoted-idmember
      def remove_sticker(card_id, sticker_id)
        delete_card_resource card_id, 'stickers', sticker_id
      end

      # Delete a card resource
      def delete_card_resource(card_id, resource, *paths)
        delete card_path(card_id, camp(resource), *paths)
      end

      def card_path(*paths)
        path_join "cards", *paths
      end
    end
  end
end
