package com.company;

public class Tester {





    /*public static void main(String[] args) {
        System.out.println("Здраствуй, мир!");// вывод
        System.out.println("Здраствуй \nмир!");// \n - новая строка; \t - как таб
    */
        /*
        int age;
        age = 56;

        System.out.println("Возраст:" + age);// пиши sout и выдаст полную форму

        String user_name = "Alex";
        System.out.println("Имя пользователя:" + user_name);

        //ввод данных в консоли
        Scanner scan = new Scanner(System.in);
        System.out.println("Введите ваше имя:");
        String nameuser = scan.nextLine();//запись в переменную или получение строки
        System.out.println("Здраствуй," + nameuser);

        System.out.println("Введите ниже число:");
        int num1 = scan.nextInt(); //для получения числа
        System.out.println("Вы ввели:" + num1);

        //применяем функцию
        int vs = MathJ();
        System.out.println(vs);

        //простейший калькулятор
        System.out.println("Введите Первое число:");
        float a1 = scan.nextFloat();

        System.out.println("Введите Второе число:");
        float a2 = scan.nextFloat();

        float res1 = a1 + a2;
        float res2 = a1 - a2;
        float res3 = a1 / a2;
        float res4 = a1 * a2;
        float res5 = a1 % a2;

        System.out.println("Результат:");
        System.out.println(res1 + "\n" + res2 + "\n" + res3 + "\n" + res4 + "\n" + res5 + "\n");

        //условные операторы if-else
        int a = 15, b = 10;
        if (a > b) {
            System.out.println("Да, условие верно");
        } else if(a >= b) {
            System.out.println("Да, условие верно");
        } else {
            System.out.println("Нет, условие ошибочное");
        }
        //если одна строчка кода в теле условия, то можно фигурные скобки удалить

        Scanner scan = new Scanner(System.in);
        System.out.print("Введите роль по-английски:");
        String role = scan.nextLine();
        System.out.print("Введите пароль:");
        String pass = scan.nextLine();

        //метод equals() позволяет проверить значение переменной. Для работы со строками
        if (role.equals("Admin") && pass.equals("12345") )
            System.out.println("Добрый день, Мастер. Доступ ко всему открыт");
         else {
            System.out.println("Привет, как вас зовут?");
            String name = scan.nextLine();
        }


        //условные операторы switch - case (одна переменная - куча сравнений)
        Scanner scan = new Scanner(System.in);
        int num = scan.nextInt();

        switch (num) {
            case 1:
                System.out.println("number is 1");
                break;
            case 2:
                System.out.println("number is 2");
                break;
            case 3:
                System.out.println("number is 3");
                break;
            //default срабатывает, когда нет значений удовлетворяющих кейсы
            default:
                System.out.println("End");
        }

        //калькулятор по-лучше :D
        Scanner scan = new Scanner(System.in);
        System.out.print("Введите 1 число:");
        int num1 = scan.nextInt();

        System.out.print("Введите 2 число:");
        int num2 = scan.nextInt();

        int res;

        System.out.print("Значок Действия:");
        String des = scan.nextLine();
        des = scan.nextLine();


        switch (des) {
            case  "+":
                res = num1 + num2;
                System.out.println("Результат:" + res);
                break;

            case  "-":
                res = num1 - num2;
                System.out.println("Результат:" + res);
                break;

            case  "*":
                res = num1 * num2;
                System.out.println("Результат:" + res);
                break;

            case  "/":
                if (num2 == 0)
                    System.out.println("ERROR");
                else {
                    res = num1 / num2;
                    System.out.println("Результат:" + res);
                }
                break;

            case  "%":
                res = num1 % num2;
                System.out.println("Результат:" + res);
                break;

            default:
                System.out.println("Ошибка ввода");
        }
         */
}
//работа с циклами