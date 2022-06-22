#Online Bash Shell.
#Code, Compile, Run and Debug Bash script online.
#Write your code in this editor and press "Run" button to execute it.

USER_PASSWORD="user"
ADMIN_PASSWORD="admin"
USER_LOGGED=false
ADMIN_LOGGED=false

admin_meni (){
    echo "Choose option:"
    echo "1. Create patient"
    echo "2. Edit patient"
    echo "3. Delete patient"
    echo "4. Display list of patient"
    echo "5. Create hospital ward"
    echo "6. Log-in/Log-Out"
    echo "7. Exit"
    
read ADMIN_OPTION
case $ADMIN_OPTION in

  1)
    patient_create
    ;;

  2)
    patient_edit
    ;;

  3)
    patient_delete
    ;;
  4)
    patient_display_list
    ;;
  5)
    hospital_ward
    ;;
  6)
    log_in
    ;;
  7)
    exit
    ;;
  *)
    admin_meni
    ;;
esac
#Switch/case za odabir opcije
#Admin Opcije
}
patient_create (){
    
    echo "Enter patient's first name:"
    read all_patients[${#all_patients[@]}]
    echo "Enter patient's last name:"
    read all_patients[${#all_patients[@]}]
    echo "Enter patient's adress:"
    read all_patients[${#all_patients[@]}]
    echo "Enter patient's ID:"
    read all_patients[${#all_patients[@]}]
    echo "Enter patient's analysis:"
    read all_patients[${#all_patients[@]}]
   
    patient_list
    admin_meni
    
}
patient_edit (){
    patient_list
    echo "Choose patient to edit:"
    
    read CHOOSED_N
    CHOOSED_N=$(( CHOOSED_N*5 ))
    #mnozimo s 5 zbog indexa
    
    echo "Choose option:"
    echo "1. Edit first name"
    echo "2. Edit last name"
    echo "3. Edit adress"
    echo "4. Edit ID"
    echo "5. Edit analysis:"
    
    read EDIT_OPTION
    
    case $EDIT_OPTION in

    1) 
    echo "Edit first name:"
    m=$(( CHOOSED_N-5 ))
    read all_patients[m]
    ;;

    2)
    echo "Edit last name:"
    m=$((CHOOSED_N-4))
    read all_patients[m]
    ;;
    
    3)
    echo "Edit adress:"
    m=$((CHOOSED_N-3))
    read all_patients[m]
    ;;
    4)
    echo "Edit ID:"
    m=$((CHOOSED_N-2))
    read all_patients[m]
    ;;
    5)
    echo "Edit analysis:"
    m=$((CHOOSED_N-1))
    read all_patients[m]
    ;;
    *)
    echo -n "unknown"
    ;;
#varijable a,c,m... sluze samo za indexiranje

esac
patient_list
admin_meni
}

patient_delete(){
    patient_list
    echo "Select patient to delete"
    read DELETE_P
    
    if [ $DELETE_P -eq 1 ]
    then
    DELETE_P=$(( DELETE_P * 5 ))
    
    all_patients=( "${all_patients[@]:${DELETE_P}:${#all_patients[@]}}" )
    #U slucaju da je odabran pacijent pod brojem 1 onda se niz sjece od indexa 5 pa do kraja niza
    else
    DELETE_P=$(( DELETE_P * 5 ))
    CUT=$(( DELETE_P -5 ))
    
    all_patients=( "${all_patients[@]:0:${CUT}}" "${all_patients[@]:${DELETE_P}}" )
    fi
    
    patient_list
    admin_meni
    #array=("${array[@]:1}")
}

patient_list (){
    a=0
    ON=1
    while [ $a -lt ${#all_patients[@]} ]
    do
    echo "$ON.  ${all_patients[a]}"
    a=$(( a+1 ))
    echo "    ${all_patients[a]}"
    a=$(( a+1 ))
    echo "    ${all_patients[a]}"
    a=$(( a+1 ))
    echo "    ${all_patients[a]}"
    a=$(( a+1 ))
    echo "    ${all_patients[a]}"
    a=$(( a+1 ))
    ON=$(( ON+1 ))
    echo " "
    done
#ON varijabla je Ordinal number (redni broj)
}
patient_display_list(){
    patient_list
    admin_meni
}
hospital_ward(){
    echo "Create new hospital ward,enter a name:"
    read WARD[${#WARD[@]}]
    hospital_ward_list
    admin_meni
}
hospital_ward_list(){
    for (( p=0; p<${#WARD[@]}; p++ ))
    do
    echo "$p. ${WARD[$p]}"
    done
}

log_in(){
    
echo "Enter your username"
read USER_NAME

echo "Enter your password"
read PASSWORD_ENTERED

if [ "$PASSWORD_ENTERED" == "$ADMIN_PASSWORD" ]
then
    ADMIN_LOGGED=true
    USER_LOGGED=false
    echo "Logged in as admin"
elif [ "$PASSWORD_ENTERED" == "$USER_PASSWORD" ]
then
    ADMIN_LOGGED=false
    USER_LOGGED=true
    echo "Logged in as user"
else
echo "wrong password"
exit
fi
if [ "$ADMIN_LOGGED" == true ]
then
   admin_meni
   
#Admin Opcije

else 
user_meni
fi
#User Opcije
}

user_meni(){
    echo "Choose option:"
    echo "1. Show hospital records"
    echo "2. Application for admission to the department"
    echo "3. Show current cappacity"
    echo "4. Log-in/Log-Out"
    echo "5. Exit"
    
read USER_OPTION
case $USER_OPTION in

  1)
    patient_list_user
    ;;

  2)
    apply_for_admission
    ;;

  3)
    cappacity
    ;;
  4)
    log_in
    ;;
  5)
    exit
    ;;
  *)
    user_meni
    ;;
esac
}
#Validacija
patient_list_user(){
    
    for (( c=0; c<${#all_patients[@]}; c++ ))
    do
    if [ "$USER_NAME" == "${all_patients[$c]}" ]
    then
    echo "${all_patients[$c]}"
    f=$((c+1))
    echo "${all_patients[$f]}"
    f=$((c+2))
    echo "${all_patients[$f]}"
    f=$((c+3))
    echo "${all_patients[$f]}"
    f=$((c+4))
    echo "${all_patients[$f]}"
    fi
    done
    user_meni
}
apply_for_admission(){
    hospital_ward_list
    echo "Choose ward"
    read WARD_C
    WARD_CHOSEN="${WARD[$WARD_C]}"
    user_meni
}
cappacity(){
    for (( u=0; u<${#WARD[@]}; u++ ))
    do
    if [ "$WARD_CHOSEN" == "${WARD[$u]}" ]
    then
    echo "${WARD[$u]}----THIS USER"
    else
    echo "${WARD[$u]}---"
    fi
    done
    user_meni
}
log_in