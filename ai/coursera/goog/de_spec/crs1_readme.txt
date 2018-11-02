google specialization

course 1   GCP fundamentals 


resources:
GCP                         https://cloud.google.com
datacenters                 https://www.google.com/about/datacenters
google it security      
                            https://cloud.google.com/files/Google-CommonSecurity-WhitePaper-v1.4.pdf
Why Google Cloud Platform   https://cloud.google.com/why-google 
Pricing Philosophy          https://cloud.google.com/pricing/philosophy



compute engine              https://cloud.google.com/compute
Storage                     https://cloud.google.com/storage
Pricing                     https://cloud.google.com/pricing
Cloud Launcher              https://cloud.google.com/marketplace 
Pricing Philosophy          https://cloud.google.com/pricing/philosophy 










    cpu units   and storage units

    cloud dataprc = hosted hadoop pyspark

    cloud: servers are not owned by you



    edge locations
    if ressouces accessed from africa, the 2nd client should acccess
    it as cached from a nearby location

    2 machines in a data center are 1 hop away

    HDFS is based on GFS and MapReduce

    GFS -> Colossus FS 

    Dremel  -> BigQuery
    Flume  ->  DataFlow 


    cloud beneficially if you are running ephemereally (when you need them)

    pay a job on 1000 cpus running for 10 secs 

    spotify uses  google cloud
         not to pay less 
         more secure calcs
         no ops, just submit a job 

    .2 B rows -> 20 K in < 1 min
    > big time savings == (worth of employees time)
      (massive scaling of computations)

    mysql -> migrate ->  cloud sql 

    dataproc  : resize clusters very quickly

    folks move to cloud to use innovative products


    GCP  use-cases
        1. movie rendering  on GCP   (client changes place where they compute)
        
        2. FIS  has 6 B market events per hour  6 TB/hr  1.7G/s  (no tx is lost) (big scaling with no data loss)

        3. rooms to go tranformed its business with data and ML
            help transform the company to data driven organization


Modu: Foundations to GCP Compute and Storage
    cpus, storage, networking 


    cloud computer is a computer
        cloud cpu
        cloud storage 
        cloud networking 

        user do not work at the level of VMs
            working as no-ops as possible,  minimize sysadmin overhead 
            don't reserve vms for long time
        always get load-balancing, premium network etc 
        you want to use machines few mins 
        some jobs will execute during hours 

        idea: preemptive vm.   for a 80% discount  they agree to let it go if somebody came and took this machine  (useful for hadoop jobs, hadoop is fault tolerant)

    cloud storage:
        blob storage
        cloud storage = persistant storage
        1st step  get your data into cloud storage 
        gsutil  cp sales*.csv 
        data is copied to buckets (they have domain names, use corp domain name)
        gs://acme-sales/data/  (conventional  it is a name to blob)
        mb make bucket
        rb remove bucket 
        rsync  (emulation of unix rsync)

        interact with cloud storage using the rest api


        acl to anybody with google account
        acl to all users without authentication       



Qwiklabs  intro 

    startLab  button (provision temp instance) in chrome incognito window
    button open google concole    (user generated google name and password)
    see the screen google cloud platform


    >  activate google cloud shell
    button end lab  (stop provisioning ),  copy and paste your code somewhere else


    Demo 1.  open console in incognition mode
    https://console.cloud.google.com


    gcp console:  navigation menu -> compute engine
        allow full access to cloud apoi
        Create

    >sudo apt-get -y -qq install git
    >sudo su 

    Demo 2.  google cloud storage
    > git clone https://github.com/GoogleCloudPlatform/training-data-analyst
    > cd ~/training-data-analyst/CPB100/lab2b
    > cat ingest.sh 
    >install_missing.sh
    >python3 transform.py

    console > Storage -> create bucket
    bucket name  == project id = qwiklabs-gcp-607c08bc07f8ea45
    >gsutil cp earthquakes.* gs://qwiklabs-gcp-607c08bc07f8ea45/earthquakes/
    >gsutil acl ch -u ALLUsers:R gs://qwiklabs-gcp-607c08bc07f8ea45/earthquakes/*


    pricing calculator
    https://cloud.google.com/pricing/

    left menu -> calulators


chap: Data Analysis on the cloud 
    Google provides managed services 

    migrate to the cloud mysql db   or hadoop instance 

    first developed: App Engine: to run webapps (serverless running of webapps from 2008)
    google app engine
        java
        python Flask
        ... others 

    for non-web app.  put it in container  and run in in google container engine 

    compute engine  use it as a vm to run your business application 

    DataProc = Hadoop cluster on GCP
    CloudSQL = managed mysql on GCP 

    cloudSQL
        reachable from anywhere
        fast connects from gcp 
        protected by google security
        







