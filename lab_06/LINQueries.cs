using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace LINQ_to_Object
{
    [Serializable]
    public class Musicians: IComparable<Musicians>, IFormattable
    {
        public Musicians(int id, string name, int people_count, int birthyear, bool is_dead, string country)
        {
            this.Id = id;
            this.Name = name;
            this.PeopleCount = people_count;
            this.Birthyear = birthyear;
            this.IsDead = is_dead;
            this.Country = country;
        }

        public int Id { get; set; }
        public string Name { get; set; }
        public int PeopleCount { get; set; }
        public int Birthyear { get; set; }
        public bool IsDead { get; set; }
        public string Country { get; set; }

        public override string ToString()
        {
            return String.Format("{0}", Name);
        }
        public string ToString(string format)
        {
            return ToString(format, null);
        }

        public string ToString(string format, IFormatProvider formatProvider)
        {
            switch (format)
            {
                case null:
                case "N":
                    return ToString();
                case "I":
                    return Id.ToString();
                case "NA":
                    return Name;
                case "PC":
                    return PeopleCount.ToString();
                case "B":
                    return Birthyear.ToString();
                case "ID":
                    return IsDead.ToString();
                case "C":
                    return Country;
                case "All":
                    return String.Format("#ID:{0}\tName:{1}\tPeople Count:{2}\tBirthyear:{3}\tIsDead:{4}\tCountry:{5}", Id, Name, PeopleCount, Birthyear, IsDead, Country);
                default:
                    throw new FormatException(String.Format("Format {0} not supported", format));
            }
        }
        
        public int CompareTo(Musicians other)
        {
            if (other == null) throw new ArgumentNullException("other");

            return this.Name.CompareTo(other.Name);
        }
    }

    public static class MusicFestival
    {
        private static List<Musicians> musicians;

        public static IList<Musicians> GetMusicians()
        {
            if (musicians == null)
            {
                musicians = new List<Musicians>(10);
                musicians.Add(new Musicians(1, "Biblia Rapers", 3, 2000, false,  "United States"));
                musicians.Add(new Musicians(2, "Lenin's Dragons", 3, 2001, true, "Russia"));
                musicians.Add(new Musicians(3, "Utsu-P", 4, 2018, false, "Japan"));
                musicians.Add(new Musicians(4, "Sex in sky", 2, 2007, false, "Serbia"));
                musicians.Add(new Musicians(5, "Heavy Chansoner", 1, 2010, false, "Russia"));
                musicians.Add(new Musicians(6, "Sci Clones", 3, 1998, false, "Germany"));
                musicians.Add(new Musicians(7, "Vasilililia", 1, 2002, true, "Ukraine"));
                musicians.Add(new Musicians(8, "Julian Bembers", 1, 2000, false, "United States"));
                musicians.Add(new Musicians(9, "Unusual Pop Makers", 2, 1997, true, "Belgia"));
                musicians.Add(new Musicians(10, "Graveborn", 3, 2012, false, "Russia"));
            }
            return musicians;
        }

    }

    class Program
    {
        static void Main(string[] args)
        {
            GetDeadMusicGroups();
            GetAliveMusiciansNames();
            TypeFiltering();
            IndexFiltering();
            VeryHollowQuery();
            Console.WriteLine("That's all...");
            Console.ReadLine();
        }

        static void GetDeadMusicGroups()
        {
            Console.WriteLine("This is GetDeadMusicGroups...\n");
            var query = from m in MusicFestival.GetMusicians()
                        where m.PeopleCount > 1 && m.IsDead
                        select m;
            foreach(var m in query)
            {
                Console.WriteLine(m.ToString("All"));
            }
        }

        static void GetAliveMusiciansNames()
        {
            Console.WriteLine("This is GetAliveGroups...\n");
            var query = from m in MusicFestival.GetMusicians()
                       where m.IsDead == false
                       select m;

            foreach (var m in query)
            {
                Console.WriteLine("{0}\n", m.Name);
            }
        }

        static void TypeFiltering()
        {
            object[] data = { "one", 2, 3, "four", "five", 6 };
            var query = data.OfType<string>();
            foreach (var s in query)
            {
                Console.WriteLine(s);
            }
        }

        static void IndexFiltering()
        {
            var query = MusicFestival.GetMusicians().Where((m, index) => m.Name.StartsWith("N") && index > 5);
            foreach (var m in query)
            {
                Console.WriteLine("{0}\n", m.Name);
            }
        }

        static void AllDeadMusicians()
        {
            Console.WriteLine("\nAll dead musicians:\n");
            var query = from m in MusicFestival.GetMusicians()
                                 where m.IsDead == true
                                 orderby m.Id descending
                                 select m.Name;

            foreach (var m in query)
            {
                Console.WriteLine(m);
            }
        }

        static void VeryHollowQuery()
        {
            Console.WriteLine("\nVery Strange Query:\n");
            var query = from m1 in
                            (from m1 in MusicFestival.GetMusicians()
                             where m1.Birthyear >= 2010
                             select new { m1.Name, m1.PeopleCount })
                        join m2 in
                        (from m2 in MusicFestival.GetMusicians()
                         where m2.Birthyear < 2010 && m2.IsDead
                         select new { m2.Name, m2.PeopleCount }) on m1.PeopleCount equals m2.PeopleCount
                        select new { m1.Name, m2.PeopleCount};
            foreach (var m in query)
            {
                Console.WriteLine("Name:{0}\tPeople Count:{1}", m.Name, m.PeopleCount);
            }
        }
    }   //Осталось написать с group и let
}