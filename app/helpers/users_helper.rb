module UsersHelper
    def choose_new_or_edit
        if action_name == 'new' || action_name == 'create'
            users_path
        elsif action_name == 'edit'
            user_path
        end
    end
end
