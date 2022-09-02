col_red="#A62B1F"

col_tinted_green="#214001"

col_green="#19EC41"

color_text () {
    gum style --foreground "$1" "$2"
}

branch(){
    git branch "$1"
}

get_git_user(){
    git config --global user.name
}

gum style \
--border-foreground 12 --border double \
--align center --width 50 --margin "1 2" --padding "2 4" \
"$(color_text $col_red 'Gish')" \
"$(color_text $col_tinted_green 'A simple git wrapper specifically made for')" \
"$(color_text $col_tinted_green 'ESA Programming Club')"


option=$(gum choose --cursor.foreground="$col_green" \
"Clone Repo" "Create Branch" "Delete Branch" "Switch Branch" "Submit (commit and push)")

case $option in
    "Clone Repo")
        repo_url=$(gum input --cursor.foreground="$col_green" --placeholder "Enter url of the repository")
        $(gum confirm "Are you sure you want to clone this repo?" \
         --selected.background="$col_green" && git clone $repo_url || \
         echo "echo Process has been cancelled")
    ;;
    
    "Create Branch")
        choice=$(gum choose --cursor.foreground="$col_green" "Create branch automatically" "Create branch manually")
        case $choice in
            "Create branch automatically")
                branch_name=$(get_git_user)
                branch $branch_name && \
                echo $(color_text $col_tinted_green "$branch_name branch has been created successfully") \
                || echo $(color_text $col_red "An error occurred")
            ;;

            "Create branch manually")
                branch_name=$(gum input --cursor.foreground="$col_green" --placeholder "Enter name of the branch")
                branch $branch_name && \
                echo $(color_text $col_tinted_green "$branch_name branch has been created successfully") \
                || echo $(color_text $col_red "An error occurred")
            ;;
        esac

       $(gum confirm "Do you want to switch to the newly created branch" --selected.background="$col_green" && \
       git checkout $branch_name || echo '')
        
    ;;
    
    "Delete Branch")
        branch_name=$(gum choose --cursor.foreground="$col_red" $(git branch --format="%(refname:short)"))
        git branch -D $branch_name && echo "" || echo $(color_text $col_red "An error occurred")
    ;;
    
    "Switch Branch")
        echo "Choose branch to switch to:"
        branch_name=$(gum choose --cursor.foreground="$col_green" $(git branch --format="%(refname:short)"))
        git checkout $branch_name && echo "" || echo $(color_text $col_red "An error occurred")
    ;;
    
    "Submit (commit and push)")
        echo "Which Branch do you want push?"
        choice=$(gum choose --cursor.foreground="$col_green" "Current Branch" "Other Branch")

        case $choice in
            "Current Branch")
                branch_name=$(git branch --show-current)
                $(gum confirm "Are you sure you want to push this branch $(color_text $col_green $branch_name)" --selected.background="$col_green" && \
                git add . && git commit -m "$branch_name :alembic:" && git push origin HEAD:$branch_name || echo '')
            ;;
        
            "Other Branch")
                echo "Choose branch:"
                branch_name=$(gum choose --cursor.foreground="$col_red" $(git branch --format="%(refname:short)"))
                $(gum confirm "Are you sure you want to push this branch $(color_text $col_green $branch_name)" --selected.background="$col_green" && \
                git add . && git commit -m "$branch_name :alembic:" && git push origin HEAD:$branch_name || echo '')
            ;;

        esac

        
    ;;
esac
