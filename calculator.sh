#!/bin/bash

# для более удобного вида создаем функции, чтобы в дальйнешем их вывести

# функция для первого и второго числа, где проверяется ввел ли пользователь число или ничего не вывел 
# (если ввелось не число, то программа заново дает его ввести, в случае с пустой строкой - выдает ошибку)

red='\033[0;31m'
pur='\033[0;35m'
lcy='\033[1;36m'
gr='\033[0;32m'
nc='\033[0m'

function read_number() {
    echo -e -n "Введите ${pur}$1${nc} число: "
    read number
    re='^[0-9]+$'
    echo ""
    if [[ ! -n $number ]] 
    then
        echo -e "${red}Ошибка!${nc} Вы ничего не ввели!"
        read_number $1 $2
    elif [[ ! $number =~ $re ]]
    then
        echo -e "${red}Ошибка!${nc} Введенное значение не является числом"
        read_number $1 $2
    fi
    declare -n new="$2"
    new=$number
}

# функция для математических операций сложения, вычитания, деления, умножения и возведения в степень
# идет проверка на пустую строку и ввел ли пользователь одну из четырех операций

function read_math_operation() {
    operations=("+" "-" "/" "*" "^")
    echo -e -n "Введите математическую ${gr}операцию${nc}: " 
    read operation
    echo ""
    if [[ ! -n $operation ]] 
    then
        echo -e "${red}Ошибка!${nc} Вы ничего не ввели!"
        read_math_operation
    elif ! [[ "${operations[@]}" =~ "$operation" ]]
    then
        echo -e "${red}Ошибка!${nc} Введена неверная операция!"
        read_math_operation
    fi
}
first_number=0
second_number=0

read_number первое "first_number"
read_number второе "second_number"
read_math_operation

if [[ $operation == "/" && $second_number -eq 0 ]]
then
    echo -e "${red}Ошибка!${nc} Делить на 0 нельзя!"
    exit 0
fi

task="$first_number $operation $second_number"
result=`bc <<< "${task//' '}"`
echo -e "${lcy}$task = $result${nc}"


# в качестве приятного дополнения, после примера появляется котик случайным образом,
# который хранится в отдельно созданном файле kittens

kittens="kittens"
cat=`shuf -n 1 $kittens`
echo -e "${pur}$cat${nc}"
