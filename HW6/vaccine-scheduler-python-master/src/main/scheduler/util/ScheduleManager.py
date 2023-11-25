# strong password check msg
AT_LEAST_EIGHT_CHAR_MSG = "At least 8 characters.\n"
MIXTURE_UPPER_AND_LOWER_MSG = "A mixture of both uppercase and lowercase letters.\n"
MIXTURE_ALPHA_AND_NUM_MSG = "A mixture of letters and numbers.\n"
AT_LEAST_ONE_SPECIAL_CHAR_MSG = "Inclusion of at least one special character, from “!”, “@”, “#”, “?”.\n"
NO_SPACE_ALLOWED_MSG = "Please do not contain any space in your password!\n"

# valid input check msg


class ScheduleManager:
    def check_password(password):
        at_least_eight_char_check = True
        mixture_upper_and_lower_check = True
        mixture_alpha_and_num_check = True
        at_least_one_special_char_check = True
        no_space_allowed_check = True
        validation_msg = "Your password must have:\n"
        
        # checker flags
        contain_upper = False
        contain_lower = False
        contain_alpha = False
        contain_num = False
        contain_special = False
        contain_space = False

        for c in password:
            if not contain_upper and c.isupper():
                contain_upper = True
                contain_alpha = True
            if not contain_lower and c.islower():
                contain_lower = True
                contain_alpha = True
            if not contain_num and c.isnumeric():
                contain_num = True
            if not contain_special and c in ["!", "@", "#", "?"]:
                contain_special = True
            if not contain_space and c.isspace():
                contain_space = True
        
        # check all conditions
        if len(password) < 8:
            at_least_eight_char_check = False
            validation_msg += AT_LEAST_EIGHT_CHAR_MSG
        if not contain_upper or not contain_lower:
            mixture_upper_and_lower_check = False
            validation_msg += MIXTURE_UPPER_AND_LOWER_MSG
        if not contain_alpha or not contain_num:
            mixture_alpha_and_num_check = False
            validation_msg += MIXTURE_ALPHA_AND_NUM_MSG
        if not contain_special:
            at_least_one_special_char_check = False
            validation_msg += AT_LEAST_ONE_SPECIAL_CHAR_MSG
        if contain_space:
            no_space_allowed_check = False
            validation_msg = NO_SPACE_ALLOWED_MSG
        
        if at_least_eight_char_check and mixture_upper_and_lower_check and mixture_alpha_and_num_check and at_least_one_special_char_check and no_space_allowed_check:
            print("strong password!")
        else:
            print(validation_msg)
            return False
        
        return True
    
    