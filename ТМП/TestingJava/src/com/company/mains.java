package com.company;

import com.fasterxml.jackson.databind.ObjectMapper;

import javax.swing.filechooser.FileSystemView;
import javax.xml.stream.*;
import java.awt.*;
import java.io.*;
import java.nio.file.*;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Scanner;
import java.util.zip.ZipEntry;
import java.util.zip.ZipInputStream;
import java.util.zip.ZipOutputStream;

import static java.nio.file.StandardOpenOption.APPEND;
import static java.nio.file.StandardOpenOption.CREATE;



public class mains {


    public static class Car implements Serializable{
        public String Name;
        public int old;

        public Car(){
        }
        public Car(String Name, int old){
            this.Name = Name;
            this.old = old;
        }

    }



    //2.Работа с файлом
    public static void workFile() {
        System.out.println("1.Создать/Записать\n" +
                "2.Чтение\n" +
                "3.Удалить");
        Scanner fileChose = new Scanner(System.in);
        System.out.print("Ввведите номер команды:");
        int chose = fileChose.nextInt();
        switch (chose) {
            case 1:
                // Преобразуйте строку в байтовый массив.
                System.out.print("Введите имя файла:");
                Scanner fileName = new Scanner(System.in);
                String fileNam = fileName.nextLine();

                System.out.print("Input text:");
                Scanner fileText = new Scanner(System.in);
                String fileTex = fileText.nextLine();
                byte data[] = fileTex.getBytes();
                Path p = Paths.get("./" + fileNam + ".txt");
                try (OutputStream out = new BufferedOutputStream(
                        Files.newOutputStream(p, CREATE, APPEND))) {
                    out.write(data, 0, data.length);
                } catch (IOException x) {
                    System.err.println(x);
                }
                break;
            case 2:
                FileDialog readDialog = new FileDialog((Frame) null, "Выбрать файл");
                readDialog.setMode(FileDialog.LOAD);
                readDialog.setVisible(true);
                Path filePath = Path.of(readDialog.getDirectory() + readDialog.getFile());
                try (InputStream fileRead = Files.newInputStream(filePath);
                     BufferedReader reader =
                             new BufferedReader(new InputStreamReader(fileRead))) {
                    String line = null;
                    while ((line = reader.readLine()) != null) {
                        System.out.println(line);
                    }
                } catch (IOException x) {
                    System.err.println(x);
                }
                break;
            case 3:
                FileDialog removeDialog = new FileDialog((Frame) null, "Выбрать файл");
                removeDialog.setMode(FileDialog.LOAD);
                removeDialog.setVisible(true);
                Path rfilePath = Path.of(removeDialog.getDirectory() + removeDialog.getFile());
                try {
                    Files.delete(rfilePath);
                } catch (NoSuchFileException x) {
                    System.err.format("%s: Нет такого" + " файла или директория%n", rfilePath);
                } catch (DirectoryNotEmptyException x) {
                    System.err.format("%s не пустой%n", rfilePath);
                } catch (IOException x) {
                    // Здесь обнаруживаются проблемы с разрешением файлов.
                    System.err.println(x);
                }
                break;
            default:

        }
    }


        //1. Получить информацию об использовании диска


        public static void getDiskInfo(){

            System.out.println("File system roots returned byFileSystemView.getFileSystemView():");
            FileSystemView fsv = FileSystemView.getFileSystemView();
            File[] roots = fsv.getRoots(); //получаем список разделов
            for (int i = 0; i < roots.length; i++) {
                System.out.println("Root: " + roots[i]);
            }

            System.out.println("Home directory: " + fsv.getHomeDirectory());

            System.out.println("File system roots returned by File.listRoots():");
            File[] f = File.listRoots();
            for (int i = 0; i < f.length; i++) {

                long freeSpace = f[i].getFreeSpace();
                long totalSpace = f[i].getTotalSpace();
                long usableSpace = totalSpace - freeSpace;

                System.out.println("Диск: " + f[i]);
                System.out.println("Название: " + fsv.getSystemDisplayName(f[i]));
                System.out.println("Всего места: " + totalSpace / 1024 / 1024 / 1024 + "G");
                System.out.println("Используется: " + usableSpace / 1024 / 1024 / 1024 + "G");
                System.out.println("---------------------------------------");
            }

        }

    //3.Работа с JSON
    public static void workJson() {
        System.out.println("1.Создать/Записать\n" +
                "2.Чтение\n" +
                "3.Удалить");
        Scanner fileChose = new Scanner(System.in);
        System.out.print("Введите номер команды:");
        int chose = fileChose.nextInt();
        switch (chose) {
            case 1:
                // Convert the string to a byte array.
                System.out.print("Input Json name, without type:");
                Scanner fileName = new Scanner(System.in);
                String fileNam = fileName.nextLine();

                System.out.print("Input car Name:");
                Scanner FIO = new Scanner(System.in);
                String fio = FIO.nextLine();
                System.out.print("Input car old:");

                Scanner AGE = new Scanner(System.in);
                int age = FIO.nextInt();
                Car car = new Car(fio, age);
                try {
                    //писать результат сериализации будем во Writer(StringWriter)
                    StringWriter writer = new StringWriter();
                    //это объект Jackson, который выполняет сериализацию
                    ObjectMapper mapper = new ObjectMapper();
                    // сама сериализация: 1-куда, 2-что
                    mapper.writeValue(writer, car);
                    //преобразовываем все записанное во StringWriter в строку
                    String result = writer.toString();

                    byte data[] = result.getBytes();
                    Path p = Paths.get("./" + fileNam + ".json");
                    try (OutputStream out = new BufferedOutputStream(
                            Files.newOutputStream(p, CREATE, APPEND))) {
                        out.write(data, 0, data.length);
                    } catch (IOException x) {
                        System.err.println(x);
                    }
                    System.out.printf("Сериализованные данные сохранены в " + fileNam);
                } catch (IOException i) {
                    i.printStackTrace();
                }
                break;
            case 2:
                FileDialog readDialog = new FileDialog((Frame) null, "Выбрать файл");
                readDialog.setMode(FileDialog.LOAD);
                readDialog.setVisible(true);
                Path filePath = Path.of(readDialog.getDirectory() + readDialog.getFile());
                String jsonString = null;
                ObjectMapper mapper = new ObjectMapper();
                Car car1;
                try (InputStream fileRead = Files.newInputStream(filePath);
                     BufferedReader reader = new BufferedReader(new InputStreamReader(fileRead))) {
                    String line = null;
                    while ((line = reader.readLine()) != null) {
                        System.out.println(line);
                        car1 = mapper.readValue(line, Car.class);
                        System.out.println("Десериализованная машина");
                        System.out.println("Модель: " + car1.Name);
                        System.out.println("Год выпуска: " + car1.old);
                    }
                } catch (IOException x) {
                    System.err.println(x);
                }
                break;
            case 3:
                FileDialog removeDialog = new FileDialog((Frame) null, "Выбрать файл");
                removeDialog.setMode(FileDialog.LOAD);
                removeDialog.setVisible(true);
                Path rfilePath = Path.of(removeDialog.getDirectory() + removeDialog.getFile());
                try {
                    Files.delete(rfilePath);
                } catch (NoSuchFileException x) {
                    System.err.format("%s: Нет такого" + " файла или директория%n", rfilePath);
                } catch (DirectoryNotEmptyException x) {
                    System.err.format("%s не пустой%n", rfilePath);
                } catch (IOException x) {
                    // File permission problems are caught here.
                    System.err.println(x);
                }
                break;
            default:
        }
    }

    //4.Работа с XML
    public static void workXml() {
        System.out.println("1.Создать/Записать\n" +
                "2.Чтение\n" +
                "3.Удалить");
        Scanner fileChose = new Scanner(System.in);
        System.out.print("Введите номер команды:");
        int chose = fileChose.nextInt();
        switch (chose) {
            case 1:
                // Convert the string to a byte array.
                System.out.print("Введите имя файла:");
                Scanner fileName = new Scanner(System.in);
                String fileNam = fileName.nextLine() + ".xml";
                try {
                    XMLOutputFactory output = XMLOutputFactory.newInstance();
                    XMLStreamWriter writer = output.createXMLStreamWriter(new FileWriter(fileNam));

                    // Открываем XML-документ и Пишем корневой элемент BookCatalogue
                    writer.writeStartDocument("1.0");
                    writer.writeStartElement("CarsCatalogue");
                    // Делаем цикл для книг
                    for (int i = 0; i < 3; i++) {
                        // Записываем Book
                        writer.writeStartElement("Car");

                        // Заполняем все тэги для книги
                        // Title
                        writer.writeStartElement("Title");
                        writer.writeCharacters("Car #" + i);
                        writer.writeEndElement();
                        // Author
                        System.out.print("Input model:");
                        Scanner author = new Scanner(System.in);
                        String authorIn = author.nextLine();

                        writer.writeStartElement("Model");
                        writer.writeCharacters("Model #" + authorIn);
                        writer.writeEndElement();
                        // Date
                        writer.writeStartElement("Date");
                        writer.writeCharacters(new SimpleDateFormat("yyyy-MM-dd").format(new Date()));
                        writer.writeEndElement();
                        // ISBN
                        writer.writeStartElement("Code");
                        writer.writeCharacters("Code #" + i * 2);
                        writer.writeEndElement();
                        // Publisher
                        writer.writeStartElement("Number");
                        writer.writeCharacters("Number #" + i);
                        writer.writeEndElement();
                        // Cost
                        writer.writeStartElement("Cost");
                        writer.writeAttribute("currency", "USD");
                        writer.writeCharacters("" + (i + 1000));
                        writer.writeEndElement();

                        // Закрываем тэг Book
                        writer.writeEndElement();
                    }
                    // Закрываем корневой элемент
                    writer.writeEndElement();
                    // Закрываем XML-документ
                    writer.writeEndDocument();
                    writer.flush();
                } catch (XMLStreamException | IOException ex) {
                    ex.printStackTrace();
                }

                break;
            case 2:
                FileDialog readDialog = new FileDialog((Frame) null, "Выбрать файл");
                readDialog.setMode(FileDialog.LOAD);
                readDialog.setVisible(true);
                String filePath = readDialog.getDirectory() + readDialog.getFile();
                try {
                    XMLStreamReader xmlr = XMLInputFactory.newInstance().createXMLStreamReader(filePath, new FileInputStream(filePath));

                    while (xmlr.hasNext()) {
                        xmlr.next();
                        if (xmlr.isStartElement()) {
                            System.out.println(xmlr.getLocalName());
                        } else if (xmlr.isEndElement()) {
                            System.out.println("/" + xmlr.getLocalName());
                        } else if (xmlr.hasText() && xmlr.getText().trim().length() > 0) {
                            System.out.println("   " + xmlr.getText());
                        }
                    }
                } catch (FileNotFoundException | XMLStreamException ex) {
                    ex.printStackTrace();
                }


                break;
            case 3:
                FileDialog removeDialog = new FileDialog((Frame) null, "Выбрать файл");
                removeDialog.setMode(FileDialog.LOAD);
                removeDialog.setVisible(true);
                Path rfilePath = Path.of(removeDialog.getDirectory() + removeDialog.getFile());
                try {
                    Files.delete(rfilePath);
                } catch (NoSuchFileException x) {
                    System.err.format("%s: Нет такого" + " файла или директория%n", rfilePath);
                } catch (DirectoryNotEmptyException x) {
                    System.err.format("%s не пустой%n", rfilePath);
                } catch (IOException x) {
                    // File permission problems are caught here.
                    System.err.println(x);
                }
                break;
            default:
        }
    }

    //5. Работа с Zip
    public static void unZipIt(String zipFile, String outputFolder) {
        byte[] buffer = new byte[1024];
        try {
            //create output directory is not exists
            File folder = new File(outputFolder);
            if (!folder.exists()) {
                folder.mkdir();
            }

            //get the zip file content
            ZipInputStream zis = new ZipInputStream(new FileInputStream(zipFile));
            //get the zipped file list entry
            ZipEntry ze = zis.getNextEntry();

            while (ze != null) {
                String fileName = ze.getName();
                File newFile = new File(outputFolder + File.separator + fileName);
                System.out.println("file unzip : " + newFile.getAbsoluteFile());

                //create all non exists folders
                //else you will hit FileNotFoundException for compressed folder
                new File(newFile.getParent()).mkdirs();

                FileOutputStream fos = new FileOutputStream(newFile);

                int len;
                while ((len = zis.read(buffer)) > 0) {
                    fos.write(buffer, 0, len);
                }

                fos.close();
                ze = zis.getNextEntry();
            }

            zis.closeEntry();
            zis.close();

            System.out.println("Done");
        } catch (IOException ex) {
            ex.printStackTrace();
        }
    }

    public static void workZip() {
        System.out.println("1.Создать/Записать\n" +
                "2.Чтение\n" +
                "3.Удалить");
        Scanner fileChose = new Scanner(System.in);
        System.out.print("Введите номер команды:");
        int chose = fileChose.nextInt();
        switch (chose) {
            case 1:
                // Convert the string to a byte array.
                System.out.print("Введите название файла:");
                Scanner zipName = new Scanner(System.in);
                String zipNam = zipName.nextLine();

                FileDialog readZipDialog = new FileDialog((Frame) null, "Выбрать файл");
                readZipDialog.setMode(FileDialog.LOAD);
                readZipDialog.setVisible(true);
                String filePathZip = readZipDialog.getDirectory() + readZipDialog.getFile();
                Path zipPath = Paths.get("./" + zipNam + ".zip");

                try (ZipOutputStream zout = new ZipOutputStream(new FileOutputStream(String.valueOf(zipPath)));
                     FileInputStream fis = new FileInputStream(filePathZip);) {
                    ZipEntry entry1 = new ZipEntry(readZipDialog.getFile());
                    zout.putNextEntry(entry1);
                    // считываем содержимое файла в массив byte
                    byte[] buffer = new byte[fis.available()];
                    fis.read(buffer);
                    // добавляем содержимое к архиву
                    zout.write(buffer);
                    // закрываем текущую запись для новой записи
                    zout.closeEntry();
                } catch (Exception ex) {
                    System.out.println(ex.getMessage());
                }

                break;
            case 2:
                FileDialog readDialog = new FileDialog((Frame) null, "Выбрать файл");
                readDialog.setMode(FileDialog.LOAD);
                readDialog.setVisible(true);
                String pathZip = readDialog.getDirectory() + readDialog.getFile();
                unZipIt(pathZip,readDialog.getDirectory());
                break;
            case 3:
                FileDialog removeDialog = new FileDialog((Frame) null, "Выбрать файл");
                removeDialog.setMode(FileDialog.LOAD);
                removeDialog.setVisible(true);
                Path rfilePath = null;
                try {
                    rfilePath = Path.of(removeDialog.getDirectory() + "text.txt");
                    Files.delete(rfilePath);

                    rfilePath = Path.of(removeDialog.getDirectory() + "archive.zip");
                    Files.delete(rfilePath);
                } catch (NoSuchFileException x) {
                    System.err.format("%s: Нет такого" + " файла или директория%n", rfilePath);
                } catch (IOException x) {
                    // File permission problems are caught here.
                    System.err.println(x);
                }

                break;
            default:
        }
    }

         public static void main(String[] args) {
             System.out.println("1.Информация о диске\n" +
                     "2.Работа с файлами\n" +
                     "3.Работа с JSON\n" +
                     "4.Работа с XML\n" +
                     "5.Работа с ZIP");
             Scanner in = new Scanner(System.in);
             System.out.print("Введите номер задания:");
             int chose = in.nextInt();
             switch (chose) {
                 case 1:
                     getDiskInfo();
                     break;
                 case 2:
                     workFile();
                     break;
                 case 3:
                     workJson();
                     break;
                 case 4:
                     workXml();
                     break;
                 case 5:
                     workZip();
                     break;
                 default:

             }
         }

}

//void - говорит, что функция ничего не возвращает
/*
многострочный
коммент
 */

/* ТИПЫ ДАННЫХ
byte [-128,127] - занимает 1 байт
short [-32767; 32767] - занимает 2 байта
int [-2147483658; 2147483647] - занимает 4 байта
long - занимает 8 байт
float
double - после запятой влезает больше чисел,чем во float
char - для хранения одного символа, запись:
                                           char st = "T"
string - для текста
boolean - true/false
 */






























































































