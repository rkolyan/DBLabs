using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Xml.Linq;

namespace LinqToXml
{
    class Program
    {
        static void Main(string[] args)
        {
            ReadXML();
            UpdateXML();
            ChangeXML();
            Console.WriteLine("Press ENTER to exit...");
            Console.ReadLine();
        }

        // ПРИМЕР 1. ЧТЕНИЕ ОДНОГО ЭЛЕМЕНТА ИЗ ДОКУМЕНТА XML
        static void ReadXML()
        {
            Console.WriteLine("This is result of ReadXML:");
            XDocument xdoc = XDocument.Load(@"b1.xml");
            Console.WriteLine(xdoc);
            Console.ReadLine();
        }

        // ПРИМЕР 2. МОДИФИКАЦИЯ ДАННЫХ В ДОКУМЕНТЕ XML
        static void UpdateXML()
        {
            Console.WriteLine("This is result of UpdateXML:");
            XDocument xdoc = XDocument.Load(@"b1.xml");
            xdoc.Element("all_musicians").Element("musicians").Element("birthyear").SetValue(1999);
            Console.WriteLine(xdoc.Element("all_musicians").Element("musicians").Element("birthyear").Value);
            Console.ReadLine();
            xdoc.Save(@"b1.xml");
        }

        // ПРИМЕР 3. ДОБАВЛЕНИЕ ДАННЫХ В ДОКУМЕНТ XML
        static void ChangeXML()
        {
            Console.WriteLine("This is result of ChangeXML:");
            XDocument xdoc = XDocument.Load(@"b1.xml");
            XElement root = new XElement("musicians");
            root.Add(new XElement("musicians_id", 123));
            root.Add(new XElement("name", "Underground fobs"));
            root.Add(new XElement("people_count", 4));
            root.Add(new XElement("birthyear", 2012));
            root.Add(new XElement("is_dead", true));
            root.Add(new XElement("country", "Russia"));
            xdoc.Element("all_musicians").Add(root);
            var query = from people in xdoc.Descendants("musicians")
                        select people.Value;
            Console.WriteLine("Найдено {0} музыкальных исполнителей:", query.Count());
            Console.WriteLine();
            foreach (var item in query)
            {
                Console.WriteLine(item);
            }
            xdoc.Save(@"b1.xml");
        }
    }
}
