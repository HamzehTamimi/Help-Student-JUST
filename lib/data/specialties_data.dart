// lib/data/specialties_data.dart
List<Map<String, dynamic>> specialtiesData = [
  {
    'id': 8, // Keeping original ID
    'title': 'Computer Information Systems',
    'description':
        'Computer Information Systems (CIS) is a field that focuses on using technology to design, implement, and manage information systems that solve business problems and enhance organizational efficiency.',
    'academicYears': [
      {
        'yearTitle': 'First Year',
        'semesters': [
          {
            'semesterTitle':
                'First Semester', // Corresponds to PDF's "First Semester"
            'courses': [
              'HSS110 - Leader and Social Responsibility',
              'CS 101 - Introduction to programming',
              'CS 101L - Introduction to programming Lab',
              'SE 103 - Introduction to Information Technology',
              'MATH 140 - Elements Of Linear Algebra',
              'LG 101 - Communication Skills in English',
              'MATH 101 - Calculus I',
            ],
          },
          {
            'semesterTitle':
                'Second Semester', // Corresponds to PDF's "Second Semester"
            'courses': [
              'CIS 131 - Fundamentals of Information Systems',
              'SE 112 - Introduction to Object-Oriented programming',
              'SE 112L - Introduction to Object-Oriented programming Lab',
              'HSS 119 - Entrepreneurship And Innovation',
              'MATH 102 - Calculus 2',
              'MATH 241 - Discrete Mathematics',
              'LG 103 - Life Skills',
            ],
          },
          // Summer Semester removed as per PDF plan
        ],
      },
      {
        'yearTitle': 'Second Year',
        'semesters': [
          {
            'semesterTitle':
                '2nd Year 1st Semester', // Corresponds to PDF's "Third Semester"
            'courses': [
              'CS 211 - Data Structures',
              'DB 201 - Database Management Systems',
              'CIS 231 - Computer Networks',
              'HSS 112 - Academic Skills',
              'SE 232 - Object Oriented Analysis and Design',
              'LG 102 - Academic Reading and Writing',
            ],
          },
          {
            'semesterTitle':
                '2nd Year 2nd Semester', // Corresponds to PDF's "Fourth Semester"
            'courses': [
              'CIS 211 - Systems Analysis And Design',
              'CIS 221 - Internet Application Programming',
              'STAT 201 - Statistics For Computer Science',
              'CS 220 - Programming Languages',
              'EE 201 - Digital Logic Design',
              'HSS 118 - Ethics and Professional Practice',
            ],
          },
          // Summer Semester removed as per PDF plan
        ],
      },
      {
        'yearTitle': 'Third Year',
        'semesters': [
          {
            'semesterTitle':
                '3rd Year 1st Semester', // Corresponds to PDF's "Fifth Semester"
            'courses': [
              'CIS 321 - Data Warehousing And Data Mining',
              'CIS 341 - Information System Security',
              'CIS 351 - Operating Systems',
              'CIS 311 - E-Business Management',
              'HSS 113 - Arabic Language Skills',
              'Free Elective I',
            ],
          },
          {
            'semesterTitle':
                '3rd Year 2nd Semester', // Corresponds to PDF's "Sixth Semester"
            'courses': [
              'CIS 331 - Software Project Management',
              'CIS 361 - Decision Support Systems',
              'HSS 114 - Islamic Civilization',
              'Free Elective II',
              'Department Elective I',
              'Department Elective II',
            ],
          },
          // Summer Semester removed as per PDF plan
        ],
      },
      {
        'yearTitle': 'Fourth Year',
        'semesters': [
          {
            'semesterTitle':
                '4th Year 1st Semester', // Corresponds to PDF's "Seventh Semester"
            'courses': [
              'CIS 491 - Project (I)',
              'CIS 411 - Business Intelligence',
              'CIS 421 - Web Services',
              'Department Elective III',
              'Department Elective IV',
            ],
          },
          {
            'semesterTitle':
                '4th Year 2nd Semester', // Corresponds to PDF's "Eighth Semester"
            'courses': [
              'CIS 492 - Project (II)',
              'CIS 431 - Mobile Information Systems',
              'Department Elective V',
              'Department Elective VI',
              'University Elective I',
            ],
          },
          // Summer Semester removed as per PDF plan
        ],
      },
    ],
  },
  {
    'id': 1,
    'title': 'Internet Of Things',
    'description':
        'Internet of Things (IoT) focuses on connecting everyday devices to the internet, enabling them to collect and exchange data to create smart, automated systems.',
    'academicYears': [
      {
        'yearTitle': 'First Year',
        'semesters': [
          {
            'semesterTitle': 'First Semester',
            'courses': [
              'IOT 101 - Introduction to IoT Systems',
              'CS 102 - Programming for IoT',
              'EE 201 - Electronics and Sensors',
              'NET 150 - Wireless Communication',
              'DATA 101 - Data Collection and Analysis',
            ],
          },
          {
            'semesterTitle': 'Second Semester',
            'courses': [
              'IOT 201 - Advanced IoT Architectures',
              'CLOUD 101 - Cloud Computing for IoT',
              'SEC 250 - IoT Security',
              'AI 150 - AI for IoT',
              'PROJ 300 - IoT Capstone Project',
            ],
          },
          {
            'semesterTitle': 'Summer Semester',
            'courses': [
              'SUMMER IOT 101 - IoT Workshop',
              'SUMMER IOT 102 - Intro to IoT Hardware',
            ],
          },
        ],
      },
      {
        'yearTitle': 'Second Year',
        'semesters': [
          {
            'semesterTitle': '2nd Year 1st Semester',
            'courses': [
              'IOT 301 - Edge Computing for IoT',
              'DATA 201 - Big Data in IoT',
              'NET 300 - Advanced Wireless Technologies',
              'ETHIC 200 - IoT Ethics and Regulations',
              'DEV 350 - Mobile Application Development for IoT',
            ],
          },
          {
            'semesterTitle': '2nd Year 2nd Semester',
            'courses': [
              'IOT 401 - Industrial IoT Systems',
              'ROB 200 - Robotics Integration with IoT',
              'UX 100 - User Experience Design for IoT',
              'BUS 100 - Business Aspects of IoT',
              'RES 400 - Research Project in IoT',
            ],
          },
          {
            'semesterTitle': 'Summer Semester',
            'courses': [
              'SUMMER IOT 201 - Advanced IoT Workshop',
              'SUMMER IOT 202 - IoT Security Best Practices',
            ],
          },
        ],
      },
      {
        'yearTitle': 'Third Year',
        'semesters': [
          {
            'semesterTitle': '3rd Year 1st Semester',
            'courses': [
              'IOT 501 - Smart Cities Solutions',
              'MLOps for IoT',
              'Distributed Ledger for IoT',
              'Embedded AI for IoT',
              'IoT Analytics',
            ],
          },
          {
            'semesterTitle': '3rd Year 2nd Semester',
            'courses': [
              'Industrial Control Systems (ICS) IoT',
              'Digital Twins for IoT',
              'IoT System Architecture',
              'Advanced IoT Security',
              'IoT Prototyping',
            ],
          },
          {
            'semesterTitle': 'Summer Semester',
            'courses': [
              'SUMMER IOT 301 - Internship in IoT',
              'SUMMER IOT 302 - Special Topics in IoT',
            ],
          },
        ],
      },
      {
        'yearTitle': 'Fourth Year',
        'semesters': [
          {
            'semesterTitle': '4th Year 1st Semester',
            'courses': [
              'Thesis Research I (IoT)',
              'IoT Entrepreneurship',
              'Regulatory Compliance in IoT',
              'Advanced Sensor Fusion',
              'Smart Health Systems',
            ],
          },
          {
            'semesterTitle': '4th Year 2nd Semester',
            'courses': [
              'Thesis Research II (IoT)',
              'IoT Capstone Project',
              'Emerging IoT Technologies',
              'Cyber-Physical Systems',
              'Professional Practice in IoT',
            ],
          },
          {
            'semesterTitle': 'Summer Semester',
            'courses': [
              'SUMMER IOT 401 - Thesis Continuation',
              'SUMMER IOT 402 - Career Preparation for IoT',
            ],
          },
        ],
      },
    ],
  },
  {
    'id': 2,
    'title': 'Cybersecurity',
    'description':
        'Cybersecurity specializes in protecting digital systems, networks, and data from cyber threats through security protocols, risk assessment, and incident response.',
    'academicYears': [
      {
        'yearTitle': 'First Year',
        'semesters': [
          {
            'semesterTitle': 'First Semester',
            'courses': [
              'SEC 101 - Introduction to Cybersecurity',
              'NET 201 - Network Security',
              'CRYPT 150 - Cryptography Fundamentals',
              'ETHIC 101 - Ethical Hacking',
              'RISK 200 - Risk Management',
            ],
          },
          {
            'semesterTitle': 'Second Semester',
            'courses': [
              'FORENSIC 201 - Digital Forensics',
              'APPSEC 250 - Application Security',
              'CLOUDSEC 101 - Cloud Security',
              'INCIDENT 300 - Incident Response & Management',
              'MALWARE 200 - Malware Analysis',
            ],
          },
          {
            'semesterTitle': 'Summer Semester',
            'courses': [
              'SUMMER CYB 101 - Cybersecurity Essentials Workshop',
              'SUMMER CYB 102 - Basic Linux for Security',
            ],
          },
        ],
      },
      {
        'yearTitle': 'Second Year',
        'semesters': [
          {
            'semesterTitle': '2nd Year 1st Semester',
            'courses': [
              'PEN 301 - Penetration Testing',
              'COMPLIANCE 101 - Security Compliance & Audit',
              'SECDEV 200 - Secure Software Development',
              'THREATINTEL 250 - Threat Intelligence',
              'CRITINFRA 300 - Critical Infrastructure Security',
            ],
          },
          {
            'semesterTitle': '2nd Year 2nd Semester',
            'courses': [
              'CYBERWAR 400 - Cyber Warfare & Geopolitics',
              'BLOCKCHAIN 101 - Blockchain Security',
              'AISEC 200 - AI in Cybersecurity',
              'RESEARCH 450 - Advanced Cybersecurity Research',
              'CAPSTONE 500 - Cybersecurity Capstone Project',
            ],
          },
          {
            'semesterTitle': 'Summer Semester',
            'courses': [
              'SUMMER CYB 201 - Capture The Flag (CTF) Training',
              'SUMMER CYB 202 - Web Application Security Basics',
            ],
          },
        ],
      },
      {
        'yearTitle': 'Third Year',
        'semesters': [
          {
            'semesterTitle': '3rd Year 1st Semester',
            'courses': [
              'Advanced Persistent Threats (APTs)',
              'OT/ICS Cybersecurity',
              'Security Operations Center (SOC) Analysis',
              'Cloud Security Architecture',
              'Identity and Access Management (IAM)',
            ],
          },
          {
            'semesterTitle': '3rd Year 2nd Semester',
            'courses': [
              'DevSecOps',
              'Quantum Cryptography',
              'Digital Rights Management',
              'Reverse Engineering Malware',
              'Cybersecurity Policy and Governance',
            ],
          },
          {
            'semesterTitle': 'Summer Semester',
            'courses': [
              'SUMMER CYB 301 - Cybersecurity Internship',
              'SUMMER CYB 302 - Advanced Penetration Testing',
            ],
          },
        ],
      },
      {
        'yearTitle': 'Fourth Year',
        'semesters': [
          {
            'semesterTitle': '4th Year 1st Semester',
            'courses': [
              'Cybersecurity Thesis Research I',
              'Incident Response Forensics',
              'Risk Management Frameworks',
              'Security Information and Event Management (SIEM)',
              'Wireless Network Security',
            ],
          },
          {
            'semesterTitle': '4th Year 2nd Semester',
            'courses': [
              'Cybersecurity Thesis Research II',
              'Cybersecurity Capstone Project',
              'Red Team / Blue Team Operations',
              'Emerging Cyber Threats',
              'Professional Certification Prep',
            ],
          },
          {
            'semesterTitle': 'Summer Semester',
            'courses': [
              'SUMMER CYB 401 - Advanced Digital Forensics',
              'SUMMER CYB 402 - Career Readiness in Cybersecurity',
            ],
          },
        ],
      },
    ],
  },
  {
    'id': 3,
    'title': 'Artificial Intelligence',
    'description':
        'Artificial Intelligence focuses on creating intelligent systems that can perform tasks typically requiring human intelligence, including machine learning and neural networks.',
    'academicYears': [
      {
        'yearTitle': 'First Year',
        'semesters': [
          {
            'semesterTitle': 'First Semester',
            'courses': [
              'AI 101 - Introduction to Artificial Intelligence',
              'ML 201 - Machine Learning Fundamentals',
              'STAT 150 - Statistics for AI',
              'PYTHON 101 - Python Programming',
              'NN 250 - Neural Networks',
            ],
          },
          {
            'semesterTitle': 'Second Semester',
            'courses': [
              'DL 301 - Deep Learning',
              'NLP 201 - Natural Language Processing',
              'CV 250 - Computer Vision',
              'RL 300 - Reinforcement Learning',
              'ETHICS 100 - AI Ethics',
            ],
          },
          {
            'semesterTitle': 'Summer Semester',
            'courses': [
              'SUMMER AI 101 - Python for Data Science',
              'SUMMER AI 102 - Math for AI',
            ],
          },
        ],
      },
      {
        'yearTitle': 'Second Year',
        'semesters': [
          {
            'semesterTitle': '2nd Year 1st Semester',
            'courses': [
              'EXPSYS 300 - Expert Systems',
              'ROBAI 200 - Robotics AI',
              'KNOWREP 250 - Knowledge Representation',
              'ADVML 350 - Advanced Machine Learning Algorithms',
              'FUZZYLOGIC 100 - Fuzzy Logic and Neural-Fuzzy Systems',
            ],
          },
          {
            'semesterTitle': '2nd Year 2nd Semester',
            'courses': [
              'GENAI 400 - Generative AI',
              'AIAPP 450 - AI Applications in Industry',
              'BIGDATA 300 - Big Data for AI',
              'THESIS 500 - AI Research Thesis',
              'CAPSTONE 550 - AI Capstone Project',
            ],
          },
          {
            'semesterTitle': 'Summer Semester',
            'courses': [
              'SUMMER AI 201 - AI Algorithm Design',
              'SUMMER AI 202 - Introduction to TensorFlow/PyTorch',
            ],
          },
        ],
      },
      {
        'yearTitle': 'Third Year',
        'semesters': [
          {
            'semesterTitle': '3rd Year 1st Semester',
            'courses': [
              'AI in Healthcare',
              'AI in Finance',
              'AI in Gaming',
              'Responsible AI',
              'AI System Deployment (MLOps)',
            ],
          },
          {
            'semesterTitle': '3rd Year 2nd Semester',
            'courses': [
              'Cognitive Computing',
              'Bayesian Networks',
              'Time Series Analysis for AI',
              'Federated Learning',
              'AI in Robotics (Advanced)',
            ],
          },
          {
            'semesterTitle': 'Summer Semester',
            'courses': [
              'SUMMER AI 301 - AI Research Internship',
              'SUMMER AI 302 - Special Topics in AI',
            ],
          },
        ],
      },
      {
        'yearTitle': 'Fourth Year',
        'semesters': [
          {
            'semesterTitle': '4th Year 1st Semester',
            'courses': [
              'AI Thesis Research I',
              'Explainable AI (XAI)',
              'AI for Cybersecurity',
              'Computer Vision (Advanced)',
              'Natural Language Generation',
            ],
          },
          {
            'semesterTitle': '4th Year 2nd Semester',
            'courses': [
              'AI Thesis Research II',
              'AI Capstone Project II',
              'AI in Autonomous Systems',
              'Ethical AI Design',
              'Professional Practice in AI',
            ],
          },
          {
            'semesterTitle': 'Summer Semester',
            'courses': [
              'SUMMER AI 401 - AI Career Workshop',
              'SUMMER AI 402 - Portfolio Development',
            ],
          },
        ],
      },
    ],
  },
  {
    'id': 4,
    'title': 'Computer Games Design And Development',
    'description':
        'Game Development combines creative design with technical programming skills to create interactive entertainment experiences across various platforms.',
    'academicYears': [
      {
        'yearTitle': 'First Year',
        'semesters': [
          {
            'semesterTitle': 'First Semester',
            'courses': [
              'GAME 101 - Game Design Fundamentals',
              'PROG 201 - Game Programming',
              'ART 150 - 3D Graphics and Animation',
              'UNITY 101 - Unity Game Engine',
              'DESIGN 200 - User Experience Design',
            ],
          },
          {
            'semesterTitle': 'Second Semester',
            'courses': [
              'UNREAL 101 - Unreal Engine Development',
              'LEVEL 200 - Level Design',
              'AUDIO 150 - Game Audio Production',
              'MULTIPLAYER 250 - Multiplayer Game Development',
              'PHYSICS 200 - Game Physics',
            ],
          },
          {
            'semesterTitle': 'Summer Semester',
            'courses': [
              'SUMMER GAME 101 - Intro to Game Art',
              'SUMMER GAME 102 - Basic C++ for Games',
            ],
          },
        ],
      },
      {
        'yearTitle': 'Second Year',
        'semesters': [
          {
            'semesterTitle': '2nd Year 1st Semester',
            'courses': [
              'AI GAME 200 - AI for Games',
              'MOBILE GAME 250 - Mobile Game Development',
              'VR/AR 100 - VR/AR Game Design',
              'MONETIZE 150 - Game Monetization Strategies',
              'PORTFOLIO 300 - Game Portfolio Development',
            ],
          },
          {
            'semesterTitle': '2nd Year 2nd Semester',
            'courses': [
              'INDIE 400 - Indie Game Development',
              'NETCODE 300 - Advanced Networking for Games',
              'PROCGEN 200 - Procedural Content Generation',
              'ADVGRAPHICS 350 - Advanced Graphics for Games',
              'CAPSTONE 500 - Game Development Capstone Project',
            ],
          },
          {
            'semesterTitle': 'Summer Semester',
            'courses': [
              'SUMMER GAME 201 - Game Level Design Workshop',
              'SUMMER GAME 202 - Character Rigging and Animation',
            ],
          },
        ],
      },
      {
        'yearTitle': 'Third Year',
        'semesters': [
          {
            'semesterTitle': '3rd Year 1st Semester',
            'courses': [
              'Console Game Development',
              'Serious Games Design',
              'Narrative Design for Games',
              'Game Production Management',
              'Shaders and Visual Effects',
            ],
          },
          {
            'semesterTitle': '3rd Year 2nd Semester',
            'courses': [
              'Optimizing Game Performance',
              'Game Analytics',
              'Game AI (Advanced)',
              'Technical Art Pipeline',
              'Game Industry Legal & Business',
            ],
          },
          {
            'semesterTitle': 'Summer Semester',
            'courses': [
              'SUMMER GAME 301 - Game Dev Internship',
              'SUMMER GAME 302 - Game Pitching & Portfolio Review',
            ],
          },
        ],
      },
      {
        'yearTitle': 'Fourth Year',
        'semesters': [
          {
            'semesterTitle': '4th Year 1st Semester',
            'courses': [
              'Game Thesis Research I',
              'Advanced Game Physics',
              'Cross-Platform Development',
              'Esports and Game Culture',
              'Emerging Game Technologies',
            ],
          },
          {
            'semesterTitle': '4th Year 2nd Semester',
            'courses': [
              'Game Thesis Research II',
              'Final Game Capstone Project',
              'Post-Release Support & LiveOps',
              'Game Company Startup Simulation',
              'Professional Practice in Game Dev',
            ],
          },
          {
            'semesterTitle': 'Summer Semester',
            'courses': [
              'SUMMER GAME 401 - Game Release Prep',
              'SUMMER GAME 402 - Career Fair & Networking',
            ],
          },
        ],
      },
    ],
  },
  {
    'id': 5,
    'title': 'Data Science',
    'description':
        'Data Science combines statistics, programming, and domain expertise to extract meaningful insights from large datasets and support data-driven decision making.',
    'academicYears': [
      {
        'yearTitle': 'First Year',
        'semesters': [
          {
            'semesterTitle': 'First Semester',
            'courses': [
              'DATA 101 - Introduction to Data Science',
              'STAT 201 - Statistical Analysis',
              'PYTHON 150 - Python for Data Science',
              'DB 101 - Database Management',
              'VIZ 200 - Data Visualization',
            ],
          },
          {
            'semesterTitle': 'Second Semester',
            'courses': [
              'MLDS 250 - Machine Learning for Data Science',
              'BIGDATA 101 - Big Data Technologies',
              'SQL 201 - Advanced SQL',
              'ETL 150 - ETL Processes',
              'PROB 100 - Probability for Data Science',
            ],
          },
          {
            'semesterTitle': 'Summer Semester',
            'courses': [
              'SUMMER DS 101 - Data Cleaning & Preprocessing',
              'SUMMER DS 102 - Intro to R for Data Analysis',
            ],
          },
        ],
      },
      {
        'yearTitle': 'Second Year',
        'semesters': [
          {
            'semesterTitle': '2nd Year 1st Semester',
            'courses': [
              'DEEPLEARN 300 - Deep Learning for Data Science',
              'NLPDS 200 - NLP in Data Science',
              'TIMESE 250 - Time Series Analysis',
              'ABTEST 150 - A/B Testing & Experimentation',
              'ETHICDS 100 - Data Ethics and Privacy',
            ],
          },
          {
            'semesterTitle': '2nd Year 2nd Semester',
            'courses': [
              'CLOUDDS 400 - Cloud Platforms for Data Science',
              'DEPLOYML 300 - MLOps and Model Deployment',
              'ADVSTAT 350 - Advanced Statistical Modeling',
              'BUSINTEL 200 - Business Intelligence',
              'CAPSTONE 500 - Data Science Capstone Project',
            ],
          },
          {
            'semesterTitle': 'Summer Semester',
            'courses': [
              'SUMMER DS 201 - Data Storytelling',
              'SUMMER DS 202 - Introduction to Spark',
            ],
          },
        ],
      },
      {
        'yearTitle': 'Third Year',
        'semesters': [
          {
            'semesterTitle': '3rd Year 1st Semester',
            'courses': [
              'Big Data Architectures',
              'Stream Processing',
              'Feature Engineering',
              'Reinforcement Learning for DS',
              'Advanced Data Visualization',
            ],
          },
          {
            'semesterTitle': '3rd Year 2nd Semester',
            'courses': [
              'Causal Inference',
              'Geospatial Data Science',
              'Econometrics for Data Science',
              'Financial Data Science',
              'Healthcare Data Science',
            ],
          },
          {
            'semesterTitle': 'Summer Semester',
            'courses': [
              'SUMMER DS 301 - Data Science Internship',
              'SUMMER DS 302 - Specialized DS Tools Workshop',
            ],
          },
        ],
      },
      {
        'yearTitle': 'Fourth Year',
        'semesters': [
          {
            'semesterTitle': '4th Year 1st Semester',
            'courses': [
              'Data Science Thesis Research I',
              'Bayesian Data Analysis',
              'Unsupervised Learning',
              'Advanced Natural Language Processing',
              'Image Analysis for Data Science',
            ],
          },
          {
            'semesterTitle': '4th Year 2nd Semester',
            'courses': [
              'Data Science Thesis Research II',
              'Data Science Capstone Project II',
              'Ethical AI in Practice',
              'Data Governance & Compliance',
              'Professional Practice in Data Science',
            ],
          },
          {
            'semesterTitle': 'Summer Semester',
            'courses': [
              'SUMMER DS 401 - Data Science Career Prep',
              'SUMMER DS 402 - Advanced Case Studies',
            ],
          },
        ],
      },
    ],
  },
  {
    'id': 6,
    'title': 'Robotics Science',
    'description':
        'Robotics Science integrates mechanical engineering, electronics, and computer science to design and build autonomous robotic systems.',
    'academicYears': [
      {
        'yearTitle': 'First Year',
        'semesters': [
          {
            'semesterTitle': 'First Semester',
            'courses': [
              'ROB 101 - Introduction to Robotics',
              'MECH 201 - Mechanical Systems',
              'CTRL 150 - Control Systems',
              'SENS 101 - Sensors and Actuators',
              'AI 200 - Robotics AI',
            ],
          },
          {
            'semesterTitle': 'Second Semester',
            'courses': [
              'KINEMATICS 200 - Robot Kinematics',
              'DYNAMICS 250 - Robot Dynamics',
              'PERCEPTION 150 - Robot Perception',
              'MOTIONPLAN 300 - Motion Planning',
              'EMBEDDEDROB 200 - Embedded Systems for Robotics',
            ],
          },
          {
            'semesterTitle': 'Summer Semester',
            'courses': [
              'SUMMER ROB 101 - Robotics Programming Basics',
              'SUMMER ROB 102 - Intro to CAD for Robotics',
            ],
          },
        ],
      },
      {
        'yearTitle': 'Second Year',
        'semesters': [
          {
            'semesterTitle': '2nd Year 1st Semester',
            'courses': [
              'HUMANROB 300 - Human-Robot Interaction',
              'MOBILE_ROB 250 - Mobile Robotics',
              'INDUSTRIAL_ROB 200 - Industrial Robotics',
              'ROS 100 - Robot Operating System (ROS)',
              'FIELD_ROB 350 - Field Robotics',
            ],
          },
          {
            'semesterTitle': '2nd Year 2nd Semester',
            'courses': [
              'LEARNING_ROB 400 - Robot Learning',
              'COGNITIVE_ROB 300 - Cognitive Robotics',
              'ETHICAL_ROB 100 - Ethical Robotics',
              'ADV_CTRL 350 - Advanced Control Systems for Robotics',
              'ROBOTICS_CAPSTONE 500 - Robotics Capstone Project',
            ],
          },
          {
            'semesterTitle': 'Summer Semester',
            'courses': [
              'SUMMER ROB 201 - Robot Arm Kinematics Workshop',
              'SUMMER ROB 202 - Computer Vision for Robotics',
            ],
          },
        ],
      },
      {
        'yearTitle': 'Third Year',
        'semesters': [
          {
            'semesterTitle': '3rd Year 1st Semester',
            'courses': [
              'Swarm Robotics',
              'Medical Robotics',
              'Agricultural Robotics',
              'Underwater Robotics',
              'Robot Grasping and Manipulation',
            ],
          },
          {
            'semesterTitle': '3rd Year 2nd Semester',
            'courses': [
              'Robot Localization and Mapping (SLAM)',
              'Humanoid Robotics',
              'Soft Robotics',
              'Robot Ethics and Safety',
              'Advanced Robot Vision',
            ],
          },
          {
            'semesterTitle': 'Summer Semester',
            'courses': [
              'SUMMER ROB 301 - Robotics Internship',
              'SUMMER ROB 302 - Drone Robotics Workshop',
            ],
          },
        ],
      },
      {
        'yearTitle': 'Fourth Year',
        'semesters': [
          {
            'semesterTitle': '4th Year 1st Semester',
            'courses': [
              'Robotics Thesis Research I',
              'Robot Reinforcement Learning',
              'Human-Robot Collaboration',
              'Autonomous Navigation',
              'AI for Robotic Decision Making',
            ],
          },
          {
            'semesterTitle': '4th Year 2nd Semester',
            'courses': [
              'Robotics Thesis Research II',
              'Robotics Capstone Project II',
              'Emerging Robot Technologies',
              'Professional Practice in Robotics',
              'Robotics Business & Innovation',
            ],
          },
          {
            'semesterTitle': 'Summer Semester',
            'courses': [
              'SUMMER ROB 401 - Advanced Robot Control',
              'SUMMER ROB 402 - Robotics Career Paths',
            ],
          },
        ],
      },
    ],
  },
  {
    'id': 7,
    'title': 'Computer Science',
    'description':
        'Computer Science provides a comprehensive foundation in programming, algorithms, and computational theory for solving complex technological problems.',
    'academicYears': [
      {
        'yearTitle': 'First Year',
        'semesters': [
          {
            'semesterTitle': 'First Semester',
            'courses': [
              'CS 101 - Introduction to Programming',
              'ALG 201 - Algorithms and Data Structures',
              'MATH 150 - Discrete Mathematics',
              'OS 200 - Operating Systems',
              'SE 250 - Software Engineering',
            ],
          },
          {
            'semesterTitle': 'Second Semester',
            'courses': [
              'OOP 200 - Object-Oriented Programming',
              'DB 201 - Database Systems',
              'NET 101 - Computer Networks',
              'ARCH 101 - Computer Architecture',
              'WEBDEV 100 - Web Development Fundamentals',
            ],
          },
          {
            'semesterTitle': 'Summer Semester',
            'courses': [
              'SUMMER CS 101 - Intro to Python',
              'SUMMER CS 102 - Web Design Basics',
            ],
          },
        ],
      },
      {
        'yearTitle': 'Second Year',
        'semesters': [
          {
            'semesterTitle': '2nd Year 1st Semester',
            'courses': [
              'COMPILER 300 - Compiler Design',
              'SECURITY 250 - Introduction to Computer Security',
              'AI 200 - Artificial Intelligence Concepts',
              'GRAPHICS 150 - Computer Graphics',
              'MOBILEDEV 200 - Mobile Application Development',
            ],
          },
          {
            'semesterTitle': '2nd Year 2nd Semester',
            'courses': [
              'PARALLEL 300 - Parallel and Distributed Computing',
              'CLOUDCOMP 250 - Cloud Computing',
              'BIGDATA 100 - Big Data Fundamentals',
              'THESIS 400 - AI Research Thesis',
              'CAPSTONE 500 - Computer Science Capstone Project',
            ],
          },
          {
            'semesterTitle': 'Summer Semester',
            'courses': [
              'SUMMER CS 201 - Advanced Data Structures',
              'SUMMER CS 202 - Introduction to Machine Learning',
            ],
          },
        ],
      },
      {
        'yearTitle': 'Third Year',
        'semesters': [
          {
            'semesterTitle': '3rd Year 1st Semester',
            'courses': [
              'Operating Systems (Advanced)',
              'Network Security (Advanced)',
              'Distributed Systems',
              'Software Architecture Patterns',
              'Theory of Computation',
            ],
          },
          {
            'semesterTitle': '3rd Year 2nd Semester',
            'courses': [
              'Computer Vision',
              'Natural Language Processing',
              'Human-Computer Interaction',
              'Cyber-Physical Systems',
              'Blockchain Technology',
            ],
          },
          {
            'semesterTitle': 'Summer Semester',
            'courses': [
              'SUMMER CS 301 - CS Internship',
              'SUMMER CS 302 - Special Topics in CS',
            ],
          },
        ],
      },
      {
        'yearTitle': 'Fourth Year',
        'semesters': [
          {
            'semesterTitle': '4th Year 1st Semester',
            'courses': [
              'CS Thesis Research I',
              'Quantum Computing',
              'Advanced Algorithms',
              'Big Data Analytics',
              'DevOps and Cloud Deployment',
            ],
          },
          {
            'semesterTitle': '4th Year 2nd Semester',
            'courses': [
              'CS Thesis Research II',
              'CS Capstone Project II',
              'Ethical Hacking and Penetration Testing',
              'Game Development (Advanced)',
              'Professional Practice in CS',
            ],
          },
          {
            'semesterTitle': 'Summer Semester',
            'courses': [
              'SUMMER CS 401 - Research Methods in CS',
              'SUMMER CS 402 - Career Development in CS',
            ],
          },
        ],
      },
    ],
  },
  {
    'id': 9,
    'title': 'Health Information Systems',
    'description':
        'Health Information Systems focuses on managing healthcare data and technology systems to improve patient care and healthcare delivery efficiency.',
    'academicYears': [
      {
        'yearTitle': 'First Year',
        'semesters': [
          {
            'semesterTitle': 'First Semester',
            'courses': [
              'HIS 101 - Healthcare Information Systems',
              'MED 150 - Medical Terminology',
              'DATA 201 - Healthcare Data Management',
              'HIPAA 101 - Healthcare Privacy and Security',
              'SYS 200 - Hospital Management Systems',
            ],
          },
          {
            'semesterTitle': 'Second Semester',
            'courses': [
              'EHR 200 - Electronic Health Records Systems',
              'TELEMED 150 - Telemedicine Technologies',
              'BIOMED 101 - Biomedical Informatics',
              'HEALTHLAW 200 - Healthcare Law and Ethics',
              'CLINDEC 250 - Clinical Decision Support Systems',
            ],
          },
          {
            'semesterTitle': 'Summer Semester',
            'courses': [
              'SUMMER HIS 101 - Intro to Medical Coding',
              'SUMMER HIS 102 - Health Data Standards',
            ],
          },
        ],
      },
      {
        'yearTitle': 'Second Year',
        'semesters': [
          {
            'semesterTitle': '2nd Year 1st Semester',
            'courses': [
              'PUBHEALTH 300 - Public Health Informatics',
              'HEALTHANALYTICS 250 - Healthcare Data Analytics',
              'IMAGING 200 - Medical Imaging Systems',
              'POPHEALTH 150 - Population Health Management',
              'INTEROP 100 - Healthcare Interoperability',
            ],
          },
          {
            'semesterTitle': '2nd Year 2nd Semester',
            'courses': [
              'AIHEALTH 400 - AI in Healthcare Systems',
              'WEARABLEHEALTH 300 - Wearable Technology in Healthcare',
              'HEALTHPM 200 - Healthcare Project Management',
              'GLOBALHEALTH 150 - Global Health Informatics',
              'HISCAPSTONE 500 - Health Information Systems Capstone',
            ],
          },
          {
            'semesterTitle': 'Summer Semester',
            'courses': [
              'SUMMER HIS 201 - Health Data Visualization',
              'SUMMER HIS 202 - Healthcare IT Security',
            ],
          },
        ],
      },
      {
        'yearTitle': 'Third Year',
        'semesters': [
          {
            'semesterTitle': '3rd Year 1st Semester',
            'courses': [
              'Health Economics & IT',
              'Nursing Informatics',
              'Pharmacy Informatics',
              'Genomic Informatics',
              'Precision Medicine Informatics',
            ],
          },
          {
            'semesterTitle': '3rd Year 2nd Semester',
            'courses': [
              'Consumer Health Informatics',
              'Clinical Research Informatics',
              'Telehealth Regulations & Ethics',
              'Health Information Exchange',
              'Usability & UI/UX in HIS',
            ],
          },
          {
            'semesterTitle': 'Summer Semester',
            'courses': [
              'SUMMER HIS 301 - HIS Internship',
              'SUMMER HIS 302 - Special Topics in Health IT',
            ],
          },
        ],
      },
      {
        'yearTitle': 'Fourth Year',
        'semesters': [
          {
            'semesterTitle': '4th Year 1st Semester',
            'courses': [
              'HIS Thesis Research I',
              'Healthcare Data Mining',
              'Population Health Analytics',
              'Quality Improvement in Healthcare IT',
              'Leadership in Health Informatics',
            ],
          },
          {
            'semesterTitle': '4th Year 2nd Semester',
            'courses': [
              'HIS Thesis Research II',
              'HIS Capstone Project II',
              'Emerging Technologies in Healthcare (e.g., Blockchain)',
              'Health IT Policy & Advocacy',
              'Professional Practice in HIS',
            ],
          },
          {
            'semesterTitle': 'Summer Semester',
            'courses': [
              'SUMMER HIS 401 - Health Informatics Project Mgmt',
              'SUMMER HIS 402 - HIS Career Pathways',
            ],
          },
        ],
      },
    ],
  },
  {
    'id': 10,
    'title': 'Software Engineering',
    'description':
        'Software Engineering applies engineering principles to software development, focusing on systematic approaches to design, development, and maintenance of large-scale software systems.',
    'academicYears': [
      {
        'yearTitle': 'First Year',
        'semesters': [
          {
            'semesterTitle': 'First Semester',
            'courses': [
              'SE 101 - Software Engineering Fundamentals',
              'PROG 201 - Advanced Programming',
              'DESIGN 150 - Software Design Patterns',
              'TEST 101 - Software Testing',
              'PROJ 200 - Project Management',
            ],
          },
          {
            'semesterTitle': 'Second Semester',
            'courses': [
              'REQUIREMENTS 200 - Software Requirements Engineering',
              'ARCHITECT 250 - Software Architecture',
              'DEVOPS 150 - DevOps Principles',
              'AGILE 100 - Agile Software Development',
              'UML 200 - Unified Modeling Language',
            ],
          },
          {
            'semesterTitle': 'Summer Semester',
            'courses': [
              'SUMMER SE 101 - Git & Version Control',
              'SUMMER SE 102 - Basic Web Development',
            ],
          },
        ],
      },
      {
        'yearTitle': 'Second Year',
        'semesters': [
          {
            'semesterTitle': '2nd Year 1st Semester',
            'courses': [
              'CLOUDSE 300 - Cloud-Based Software Engineering',
              'SECURITYSE 250 - Software Security Engineering',
              'QUALITYSE 200 - Software Quality Assurance',
              'MAINTENANCE 150 - Software Maintenance and Evolution',
              'DISTRIBUTED 100 - Distributed Systems Engineering',
            ],
          },
          {
            'semesterTitle': '2nd Year 2nd Semester',
            'courses': [
              'EMBEDDEDSE 400 - Embedded Software Engineering',
              'AISE 300 - AI in Software Engineering',
              'BIGDATASE 200 - Big Data Software Engineering',
              'THESISSE 450 - Software Engineering Thesis',
              'SECAPSTONE 500 - Software Engineering Capstone Project',
            ],
          },
          {
            'semesterTitle': 'Summer Semester',
            'courses': [
              'SUMMER SE 201 - API Design & Development',
              'SUMMER SE 202 - Containerization (Docker/Kubernetes)',
            ],
          },
        ],
      },
      {
        'yearTitle': 'Third Year',
        'semesters': [
          {
            'semesterTitle': '3rd Year 1st Semester',
            'courses': [
              'Advanced Software Testing',
              'Microservices Architecture',
              'Scalable Software Systems',
              'User Experience (UX) for SE',
              'Software Product Management',
            ],
          },
          {
            'semesterTitle': '3rd Year 2nd Semester',
            'courses': [
              'Formal Methods in SE',
              'Model-Driven Engineering',
              'Software Re-engineering',
              'Software Economics',
              'Open Source Software Development',
            ],
          },
          {
            'semesterTitle': 'Summer Semester',
            'courses': [
              'SUMMER SE 301 - SE Internship',
              'SUMMER SE 302 - Software Licensing & IP',
            ],
          },
        ],
      },
      {
        'yearTitle': 'Fourth Year',
        'semesters': [
          {
            'semesterTitle': '4th Year 1st Semester',
            'courses': [
              'Service-Oriented Architecture (SOA)',
              'Real-time Systems Engineering',
              'Software Metrics and Quality',
              'Global Software Development',
              'SE Thesis Research I',
            ],
          },
          {
            'semesterTitle': '4th Year 2nd Semester',
            'courses': [
              'SE Thesis Research II',
              'SE Capstone Project II',
              'Ethical Hacking for Software',
              'Advanced DevOps Practices',
              'Professional Practice in SE',
            ],
          },
          {
            'semesterTitle': 'Summer Semester',
            'courses': [
              'SUMMER SE 401 - Technical Interview Prep',
              'SUMMER SE 402 - Software Engineering Leadership',
            ],
          },
        ],
      },
    ],
  },
  {
    'id': 11,
    'title': 'Computer Engineering',
    'description':
        'Computer Engineering combines electrical engineering and computer science to design and develop computer hardware and embedded systems.',
    'academicYears': [
      {
        'yearTitle': 'First Year',
        'semesters': [
          {
            'semesterTitle': 'First Semester',
            'courses': [
              'CE 101 - Introduction to Computer Engineering',
              'EE 201 - Digital Logic Design',
              'ARCH 150 - Computer Architecture',
              'EMB 101 - Embedded Systems',
              'VLSI 200 - VLSI Design',
            ],
          },
          {
            'semesterTitle': 'Second Semester',
            'courses': [
              'MICROCONTROLLER 200 - Microcontrollers',
              'FPGA 150 - FPGA Design',
              'SIGNALSYS 100 - Signals and Systems',
              'COMMUNICATION 250 - Digital Communication',
              'DSP 200 - Digital Signal Processing',
            ],
          },
          {
            'semesterTitle': 'Summer Semester',
            'courses': [
              'SUMMER CE 101 - Electronics Workbench',
              'SUMMER CE 102 - Intro to C/Assembly',
            ],
          },
        ],
      },
      {
        'yearTitle': 'Second Year',
        'semesters': [
          {
            'semesterTitle': '2nd Year 1st Semester',
            'courses': [
              'NETWORKHW 300 - Network Hardware Design',
              'ROBOTICSE 250 - Robotics Engineering',
              'IOT_CE 200 - IoT for Computer Engineers',
              'SECURITYHW 150 - Hardware Security',
              'ADVARCH 350 - Advanced Computer Architecture',
            ],
          },
          {
            'semesterTitle': '2nd Year 2nd Semester',
            'courses': [
              'AIHW 400 - AI Hardware and Accelerators',
              'QUANTUMCOMP 300 - Quantum Computing Principles',
              'CYBERPHYSICAL 200 - Cyber-Physical Systems',
              'THESISCE 450 - Computer Engineering Thesis',
              'CECAPSTONE 500 - Computer Engineering Capstone Project',
            ],
          },
          {
            'semesterTitle': 'Summer Semester',
            'courses': [
              'SUMMER CE 201 - PCB Design',
              'SUMMER CE 202 - Embedded Linux',
            ],
          },
        ],
      },
      {
        'yearTitle': 'Third Year',
        'semesters': [
          {
            'semesterTitle': '3rd Year 1st Semester',
            'courses': [
              'Advanced Digital System Design',
              'Parallel Computer Architecture',
              'Fault-Tolerant Computing',
              'High-Performance Computing',
              'Reconfigurable Computing',
            ],
          },
          {
            'semesterTitle': '3rd Year 2nd Semester',
            'courses': [
              'System-on-Chip (SoC) Design',
              'Hardware Description Languages (HDL)',
              'Power-Aware Computing',
              'Bio-Inspired Computing',
              'Robotics Control Systems',
            ],
          },
          {
            'semesterTitle': 'Summer Semester',
            'courses': [
              'SUMMER CE 301 - CE Internship',
              'SUMMER CE 302 - ASIC Design Principles',
            ],
          },
        ],
      },
      {
        'yearTitle': 'Fourth Year',
        'semesters': [
          {
            'semesterTitle': '4th Year 1st Semester',
            'courses': [
              'CE Thesis Research I',
              'Advanced Embedded Systems',
              'Memory Systems Design',
              'Network Processors',
              'VLSI Testing',
            ],
          },
          {
            'semesterTitle': '4th Year 2nd Semester',
            'courses': [
              'CE Thesis Research II',
              'CE Capstone Project II',
              'Emerging Computing Paradigms',
              'Professional Practice in CE',
              'Hardware Security (Advanced)',
            ],
          },
          {
            'semesterTitle': 'Summer Semester',
            'courses': [
              'SUMMER CE 401 - Project Management for CE',
              'SUMMER CE 402 - Advanced FPGA Applications',
            ],
          },
        ],
      },
    ],
  },
  {
    'id': 12,
    'title': 'Network Engineering And Security',
    'description':
        'Network Engineering and Security focuses on designing, implementing, and securing computer networks and communication systems.',
    'academicYears': [
      {
        'yearTitle': 'First Year',
        'semesters': [
          {
            'semesterTitle': 'First Semester',
            'courses': [
              'NET 101 - Network Fundamentals',
              'SEC 201 - Network Security',
              'PROT 150 - Network Protocols',
              'ADMIN 101 - Network Administration',
              'WIRE 200 - Wireless Networks',
            ],
          },
          {
            'semesterTitle': 'Second Semester',
            'courses': [
              'ROUTING 200 - Routing and Switching',
              'FIREWALLS 150 - Firewall Management',
              'VPN 100 - VPN Technologies',
              'CLOUDNET 250 - Cloud Networking',
              'PENNET 200 - Network Penetration Testing',
            ],
          },
          {
            'semesterTitle': 'Summer Semester',
            'courses': [
              'SUMMER NES 101 - Basic Network Troubleshooting',
              'SUMMER NES 102 - Intro to Cisco CLI',
            ],
          },
        ],
      },
      {
        'yearTitle': 'Second Year',
        'semesters': [
          {
            'semesterTitle': '2nd Year 1st Semester',
            'courses': [
              'WIRELESSSEC 300 - Wireless Network Security',
              'VOIPSEC 250 - VoIP Security',
              'SCADA 200 - SCADA Network Security',
              'FORENSICNET 150 - Network Forensics',
              'CRYPTNET 100 - Network Cryptography',
            ],
          },
          {
            'semesterTitle': '2nd Year 2nd Semester',
            'courses': [
              'SDN 400 - Software-Defined Networking Security',
              'BLOCKCHAINNET 300 - Blockchain in Networking',
              'IOTNETSEC 200 - IoT Network Security',
              'THESISNET 450 - Network Engineering Thesis',
              'NETSECCAPSTONE 500 - Network Security Capstone Project',
            ],
          },
          {
            'semesterTitle': 'Summer Semester',
            'courses': [
              'SUMMER NES 201 - Advanced Routing Protocols',
              'SUMMER NES 202 - Network Security Auditing',
            ],
          },
        ],
      },
      {
        'yearTitle': 'Third Year',
        'semesters': [
          {
            'semesterTitle': '3rd Year 1st Semester',
            'courses': [
              'Network Intrusion Detection & Prevention',
              'Advanced Wireless Technologies',
              'Network Virtualization',
              'Cloud Security Operations',
              'Cyber Threat Intelligence (Network)',
            ],
          },
          {
            'semesterTitle': '3rd Year 2nd Semester',
            'courses': [
              'IoT Network Architecture & Security',
              'Industrial Control System (ICS) Networks',
              'Network Forensics & Incident Response',
              'Secure Cloud Architectures',
              'Ethical Hacking for Networks',
            ],
          },
          {
            'semesterTitle': 'Summer Semester',
            'courses': [
              'SUMMER NES 301 - Network Security Internship',
              'SUMMER NES 302 - Network Scripting (Python)',
            ],
          },
        ],
      },
      {
        'yearTitle': 'Fourth Year',
        'semesters': [
          {
            'semesterTitle': '4th Year 1st Semester',
            'courses': [
              'Network Engineering Thesis Research I',
              'Advanced Network Design & Implementation',
              'Cybersecurity Law and Policy',
              'Disaster Recovery for Networks',
              'Quantum Networking Concepts',
            ],
          },
          {
            'semesterTitle': '4th Year 2nd Semester',
            'courses': [
              'Network Engineering Thesis Research II',
              'Network Security Capstone Project II',
              'Emerging Network Technologies',
              'Professional Practice in Network Engineering',
              'Advanced Persistent Threat (APT) Defense',
            ],
          },
          {
            'semesterTitle': 'Summer Semester',
            'courses': [
              'SUMMER NES 401 - Network Performance Optimization',
              'SUMMER NES 402 - Career Paths in Network Security',
            ],
          },
        ],
      },
    ],
  },
];
