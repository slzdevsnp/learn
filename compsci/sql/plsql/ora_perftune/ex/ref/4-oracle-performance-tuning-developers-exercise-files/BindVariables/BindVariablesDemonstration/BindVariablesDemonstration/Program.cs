using System;//
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BindVariablesDemonstration
{
    class Program
    {
        static void Main(string[] args)
        {
            String termCode = "FA2011";
            String testDescription = String.Empty;

            Func<StudentGradesDao> gradesDaoCreator = null;            
            if (args.Length > 0 && args[0] == "-LITERAL")
            {
                gradesDaoCreator = CreateLiteralvalueDao;
                testDescription = "Literal Values";
            }
            else if (args.Length > 0 && args[0] == "-BIND")
            {
                gradesDaoCreator = CreateBindVariablesDao;
                testDescription = "Bind Variables";
            }
            else
            {
                Console.WriteLine("Please specify -LITERAL or -BIND");
                return;
            }
            Console.WriteLine("Running queries with {0}", testDescription);

            // Read in our datafiles before we get into the loop
            List<string[]> studentIdLists = ReadDataFiles();

            // This is the array Tasks will be added to so we can wait on all tasks
            Task[] queryTasks = new Task[studentIdLists.Count];

            // The next two lines set up the test for us.  Clear out shared sql area,
            // snapshot inital values and start out stopwatch on the client side
            int runNumber = TestSetupDao.SetupTest(testDescription);
            Stopwatch s = Stopwatch.StartNew();            

            // This loop fires off parallel tasks to query data for student grades
            for (int i = 0; i < studentIdLists.Count; i++)
            {
                string[] studentIdList = studentIdLists[i];
                StudentGradesDao dao = gradesDaoCreator();
                Task t = Task.Factory.StartNew(() => RunQuerySet(studentIdList, termCode, dao));
                queryTasks[i] = t;
            }
            Task.WaitAll(queryTasks);  // Wait for the tasks

            
            // At this point we are finished
            s.Stop();                                               // Stop the stopwatch
            TestSetupDao.FinishTest(runNumber, testDescription);    // Take the After snapshot


            // Print out the stats to the console for us to see
            List<PerformanceStat> stats = TestSetupDao.GetPerformanceStats(runNumber);
            Console.WriteLine("Run Number is {0}.", runNumber);
            Console.WriteLine("----------------------------------------------------------------------");
            Console.WriteLine("Elapsed Time (.NET)             {0:#.##} milliseconds", s.ElapsedMilliseconds);
            foreach (PerformanceStat stat in stats)
            {
                Console.WriteLine("{0,-30}  {1} {2}", stat.Name, stat.Value, stat.Units);
            }

            // Wait for the user to press a key until exiting
            Console.ReadKey();
        }


        /// <summary>
        /// 
        /// </summary>
        /// <param name="studentIdList"></param>
        /// <param name="termCode"></param>
        /// <param name="dao"></param>
        private static void RunQuerySet(string[] studentIdList, String termCode, StudentGradesDao dao)
        {
            foreach (String studentIdString in studentIdList)
            {
                int studentId = Convert.ToInt32(studentIdString);
                dao.LoadGrades(studentId, termCode);
            }
        }


        /// <summary>
        /// This is a helper method that just reads in the data files
        /// </summary>
        /// <returns></returns>
        private static List<string[]> ReadDataFiles()
        {
            List<string[]> fileData = new List<string[]>();
            fileData.Add(File.ReadAllLines("Datafiles\\Students-A.txt"));
            fileData.Add(File.ReadAllLines("Datafiles\\Students-B.txt"));
            fileData.Add(File.ReadAllLines("Datafiles\\Students-C.txt"));
            fileData.Add(File.ReadAllLines("Datafiles\\Students-D.txt"));

            return fileData;
        }




        private static StudentGradesDao CreateLiteralvalueDao()
        {
            return new LiteralValuesDao();
        }

        private static BindVariablesDao CreateBindVariablesDao()
        {
            return new BindVariablesDao();
        }


    }
}
