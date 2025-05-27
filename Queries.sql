
-------------------------------------------------------------------------DATABASE-------------------------------------------------------------------------

CREATE DATABASE Space_Museum;
USE Space_Museum;

-------------------------------------------------------------------------TABLES-------------------------------------------------------------------------

CREATE TABLE Users (
    User_ID INT PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    Email VARCHAR(255) NOT NULL,
    Password VARCHAR(255) NOT NULL,
    Role VARCHAR(255) NOT NULL
);

CREATE TABLE Administration (
    Admin_ID INT PRIMARY KEY,
    Admin_Role VARCHAR(255) NOT NULL,
    Assigned_Exhibits INT,
    Tech_Installations INT,
    Weekly_Hours INT,
    Approval_Limit_Rs INT,
    Creation_Date DATE,
	User_ID INT,
	FOREIGN KEY (User_ID) REFERENCES Users(User_ID) ON DELETE SET NULL
);

CREATE TABLE Employee (
    Employee_ID INT PRIMARY KEY,
    Employee_Role VARCHAR(255) NOT NULL,
    Weekly_Hours_Worked INT NOT NULL,
	Assigned_Shift VARCHAR(255) NOT NULL,
    Assigned_Exhibit VARCHAR(255),
    Equipment_Status VARCHAR(255),
    Last_Maintenance_Check_Date DATE NOT NULL,
    Last_Maintenance_Check_Time TIME,
    Emergency_Access VARCHAR(255),
    Creation_Date DATE NOT NULL,
    Admin_ID INT,
    User_ID INT,
    FOREIGN KEY (Admin_ID) REFERENCES Administration(Admin_ID) ON DELETE SET NULL,
    FOREIGN KEY (User_ID) REFERENCES Users(User_ID) ON DELETE SET NULL
);

CREATE TABLE Visitor (
	Visitor_ID INT PRIMARY KEY,
	Contact_Number BIGINT NOT NULL,
	Membership_Tier VARCHAR(255) NOT NULL,
	Total_Visits INT,
	Discount_Earned DECIMAL(19,0) NOT NULL,
	Family_Adults INT NOT NULL,
	Family_Kids INT NOT NULL,
	AR_Usage_Hours INT,
	VR_Usage_Hours INT,
	Preferred_Exhibits VARCHAR(255),
	Registration_Date DATE NOT NULL,
	Feedback VARCHAR(255),
	Amount_Payed DECIMAL(19,0) NOT NULL,
	Payment_Status VARCHAR(255) NOT NULL,
	Creation_Date DATE NOT NULL,
	Employee_ID INT,
	User_ID INT,
	FOREIGN KEY (Employee_ID) REFERENCES Employee(Employee_ID) ON DELETE SET NULL,
	FOREIGN KEY (User_ID) REFERENCES Users(User_ID) ON DELETE SET NULL
);

CREATE TABLE Exhibit (
    Exhibit_ID INT PRIMARY KEY,
    Exhibit_Name VARCHAR(255) NOT NULL,
    Location VARCHAR(255) NOT NULL,
    Overseeing_Start_Date DATE,
    Overseeing_End_Date DATE,
    Year_Of_Exhibit INT,
	Duration_in_Minutes DECIMAL(19,0),
    Admin_ID INT,
    Visitor_ID INT,
    FOREIGN KEY (Admin_ID) REFERENCES Administration(Admin_ID) ON DELETE SET NULL,
    FOREIGN KEY (Visitor_ID) REFERENCES Visitor(Visitor_ID) ON DELETE SET NULL
);

CREATE TABLE Projection (
    Projection_ID INT PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    Type VARCHAR(255) NOT NULL,
    Distance_from_Earth BIGINT
);

CREATE TABLE Multimedia_Equipment (
	ME_ID INT PRIMARY KEY,
    Name VARCHAR(255),
    Operational_Status VARCHAR(255),
    Admin_ID INT,
    Visitor_ID INT,
    Exhibit_ID INT,
    Projection_ID INT,
	FOREIGN KEY (Admin_ID) REFERENCES Administration(Admin_ID) ON DELETE SET NULL,
	FOREIGN KEY (Visitor_ID) REFERENCES Visitor(Visitor_ID) ON DELETE SET NULL,
    FOREIGN KEY (Exhibit_ID) REFERENCES Exhibit(Exhibit_ID) ON DELETE SET NULL,
    FOREIGN KEY (Projection_ID) REFERENCES Projection(Projection_ID) ON DELETE SET NULL
);

CREATE TABLE Planet (
    Planet_ID INT PRIMARY KEY,
    Orbital_Period_Days DECIMAL(19, 9),
    Mass DECIMAL(19, 9),
    Diameter DECIMAL(19, 9),
    Discoverer VARCHAR(255),
	Surface_Temperature DECIMAL(19, 9),
    Image_URL VARCHAR(255),
	Img_Description VARCHAR(255),
    Projection_ID INT,
    FOREIGN KEY (Projection_ID) REFERENCES Projection(Projection_ID) ON DELETE SET NULL
);

CREATE TABLE Moon (
    Moon_ID INT PRIMARY KEY,
    Orbital_Period_Days DECIMAL(19, 9),
    Mass DECIMAL(19, 9),
    Diameter DECIMAL(19, 9),
    Surface_Temperature DECIMAL(19, 9),
    Planet_ID INT,
    Projection_ID INT,
    FOREIGN KEY (Planet_ID) REFERENCES Planet(Planet_ID) ON DELETE SET NULL,
    FOREIGN KEY (Projection_ID) REFERENCES Projection(Projection_ID) ON DELETE SET NULL
);

CREATE TABLE Star (
    Star_ID INT PRIMARY KEY,
    Mass DECIMAL(19, 9),
    Diameter DECIMAL(19, 9),
    Projection_ID INT,
    FOREIGN KEY (Projection_ID) REFERENCES Projection(Projection_ID) ON DELETE SET NULL
);

-------------------------------------------------------------------------INSERT VALUES-------------------------------------------------------------------------

INSERT INTO Users (User_ID, Name, Email, Password, Role) VALUES
-- Administration (Ordered by Hierarchy)
    (1, 'Neil D. Tyson', 'neil.tyson@spacemuseum.com', 'Tys0n@Cosmos', 'Administration'),
    (2, 'Carl Sagan', 'carl.sagan@spacemuseum.com', 'Sag@nCosmos', 'Administration'),
    (3, 'Jocelyn Bell', 'jocelyn.bell@spacemuseum.com', 'Puls@r123', 'Administration'),
    (4, 'Edwin Hubble', 'edwin.hubble@spacemuseum.com', 'Hubb1eTelesc0pe', 'Administration'),
    (5, 'Vera Rubin', 'vera.rubin@spacemuseum.com', 'DarkM@tter1', 'Administration'),
    (6, 'Katherine Johnson', 'katherine.johnson@spacemuseum.com', 'N@saHero1', 'Administration'),
    (7, 'Wernher von Braun', 'wernher.braun@spacemuseum.com', 'R0cketSci3nce', 'Administration'),
    (8, 'Nancy Roman', 'nancy.roman@spacemuseum.com', 'Hubb1eM0m', 'Administration'),
    (9, 'George Ellery Hale', 'george.hale@spacemuseum.com', 'T3lescop3s', 'Administration'),
    (10, 'Amina Khan', 'amina.khan@spacemuseum.com', 'Amy@1234', 'Administration'),
    (11, 'Levi Ackerman', 'levi.ackerman@spacemuseum.com', 'Levi@7788', 'Administration'),
    (12, 'Annie Leonhart', 'annie.leonhart@spacemuseum.com', 'Any@3344', 'Administration'),
    (13, 'Emre Altan', 'emre.altan@spacemuseum.com', 'Emre@5566', 'Administration'),
-- Employees
	(14, 'Bilal Ahmed', 'bilal.ahmed@spacemuseum.com', 'Bil@5678', 'Employee'),
	(15, 'Mehmet Altan', 'mehmet.altan@spacemuseum.com', 'Alt@nP@ss', 'Employee'),
	(16, 'Omar Farooq', 'omar.farooq@spacemuseum.com', 'F@r00q!', 'Employee'),
	(17, 'Ismail Bey', 'ismail.bey@spacemuseum.com', 'Isb@9101', 'Employee'),
	(18, 'Abdul Rahman', 'abdul.rahman@spacemuseum.com', 'R@hm@n1', 'Employee'),
	(19, 'Sven Magnusson', 'sven.magnus@spacemuseum.com', 'M@gnusS', 'Employee'),
	(20, 'Magnus Johansson', 'magnus.johan@spacemuseum.com', 'J0h@nss0n', 'Employee'),
	(21, 'Lin Wei Chen', 'lin.weichen@spacemuseum.com', 'W3!Ch3n', 'Employee'),
	(22, 'Zara bint Khalid', 'zara.khalid@spacemuseum.com', 'Kh@l!dZ', 'Employee'),
-- Visitors
	(23, 'Aisha bint Yusuf', 'aisha.yusuf@gmail.com', 'Aisha123', 'Visitor'),
	(24, 'Aylin Demir', 'aylin.demir@gmail.com', 'AylinPass', 'Visitor'),
	(25, 'Alistair Winthrop', 'alistair.winthrop@gmail.com', 'Winthrop1', 'Visitor'),
	(26, 'Chen Xiao Ling', 'chen.xiaoling@gmail.com', 'ChenXiao1', 'Visitor'),
	(27, 'Edmund Blackwood', 'edmund.black@gmail.com', 'Edmund123', 'Visitor'),
	(28, 'Eleanor Cavendish', 'eleanor.cav@gmail.com', 'Eleanor123', 'Visitor'),
	(29, 'Fatima Al-Qureshi', 'fatima.qureshi@gmail.com', 'Fatima123', 'Visitor'),
	(30, 'Hiroshi Yamamoto', 'hiroshi.yama@gmail.com', 'Hiroshi123', 'Visitor'),
	(31, 'Ingrid Bergström', 'ingrid.berg@gmail.com', 'Ingrid123', 'Visitor'),
	(32, 'Ismet Sultan', 'ismet.sultan@gmail.com', 'IsmetPass', 'Visitor'),
	(33, 'Li Na Zheng', 'li.nazheng@gmail.com', 'LiNaPass', 'Visitor'),
	(34, 'Park Ji-Hoon', 'park.jihoon@gmail.com', 'JiHoon123', 'Visitor'),
	(35, 'Sakamoto Ryu', 'sakamoto.ryu@gmail.com', 'RyuPass123', 'Visitor'),
	(36, 'Takeda Nobunaga', 'takeda.nobu@gmail.com', 'NobuPass', 'Visitor'),
	(37, 'Tanaka Haruki', 'tanaka.haru@gmail.com', 'Haruki123', 'Visitor'),
	(38, 'Victoria Kensington', 'victoria.ken@gmail.com', 'Victoria1', 'Visitor'),
	(39, 'Yuki Nakamura', 'yuki.nakamura@gmail.com', 'YukiPass1', 'Visitor'),
	(40, 'Zhang Wei Long', 'zhang.weilong@gmail.com', 'ZhangPass', 'Visitor');


INSERT INTO Administration (Admin_ID, Admin_Role, Assigned_Exhibits, Tech_Installations, Weekly_Hours, Approval_Limit_Rs, Creation_Date, User_ID) VALUES
    (101, 'CEO', NULL, NULL, 50, 1000000.0, '2020-01-15', 1),
    (102, 'Senior Curator', 15, 8, 45, 500000.0, '2020-03-10', 2),
    (103, 'Curator', 10, 5, 40, 250000.0, '2021-02-20', 3),
    (104, 'Curator', 12, 6, 40, 250000.0, '2021-03-15', 4),
    (105, 'Curator', 8, 4, 40, 250000.0, '2021-04-05', 5),
    (106, 'Senior DEM', 5, 20, 45, 300000.0, '2020-06-18', 6),
    (107, 'DEM', 3, 15, 40, 200000.0, '2021-01-22', 7),
    (108, 'DEM', 4, 18, 40, 200000.0, '2021-02-10', 8),
    (109, 'DEM', 2, 12, 40, 200000.0, '2021-05-30', 9),
    (110, 'Exhibit Manager', 20, 10, 45, 400000.0, '2020-05-12', 10),
    (111, 'Security Head', NULL, NULL, 50, 300000.0, '2020-02-28', 11),
    (112, 'HR Coordinator', NULL, NULL, 40, 150000.0, '2020-04-15', 12),
    (113, 'Finance Officer', NULL, NULL, 45, 800000.0, '2020-03-01', 13);

INSERT INTO Employee (Employee_ID, Employee_Role, Weekly_Hours_Worked, Assigned_Shift, Assigned_Exhibit, Equipment_Status, Last_Maintenance_Check_Date, Last_Maintenance_Check_Time, Emergency_Access, Creation_Date, Admin_ID, User_ID) VALUES
    (201, 'Tech Supervisor', 40, 'Morning', 'Main Hall', 'Fully Operational', '2023-10-15', '09:30:00', 'Level 2', '2022-01-10', 106, 14),
    (202, 'Tech Supervisor', 40, 'Evening', 'Planetarium', 'Needs Calibration', '2023-10-12', '14:45:00', 'Level 2', '2022-02-15', 106, 15),
    (203, 'Tech Supervisor', 35, 'Night', 'Space Exploration Wing', 'Fully Operational', '2023-10-18', '23:00:00', 'Level 2', '2022-03-20', 106, 16),
    (204, 'Logistics Admin', 40, 'Morning', NULL, 'N/A', '2023-10-01', '10:00:00', 'Level 1', '2022-04-05', 110, 17),
    (205, 'Logistics Admin', 40, 'Evening', NULL, 'N/A', '2023-10-02', '18:00:00', 'Level 1', '2022-05-12', 110, 18),
    (206, 'IT Support', 40, 'Morning', NULL, 'System Updated', '2023-10-10', '08:30:00', 'Level 3', '2022-06-18', 106, 19),
    (207, 'IT Support', 40, 'Evening', NULL, 'System Updated', '2023-10-11', '17:15:00', 'Level 3', '2022-07-22', 106, 20),
    (208, 'Data Analyst', 40, 'Morning', NULL, 'N/A', '2023-10-05', '09:00:00', 'Level 1', '2022-08-30', 113, 21),
    (209, 'Visitor Services', 35, 'Flexible', 'Main Entrance', 'N/A', '2023-10-20', '11:20:00', 'Level 1', '2022-09-15', 112, 22);

--Level 3 for IT Support (full system access)
--Level 2 for Tech Supervisors (exhibit equipment access)
--Level 1 for others (basic access)

INSERT INTO Visitor (Visitor_ID, Contact_Number, Membership_Tier, Total_Visits, Discount_Earned, Family_Adults, Family_Kids, AR_Usage_Hours, VR_Usage_Hours, Preferred_Exhibits, Registration_Date, Feedback, Amount_Payed, Payment_Status, Creation_Date, Employee_ID, User_ID) VALUES
	(301, 3001234567, 'Gold', 12, 1500.0, 2, 3, 5, 4, 'Space Exploration', '2024-12-01', 'Loved the Mars exhibit!', 12000.0, 'Paid', '2024-12-01', 201, 23),
	(302, 3019876543, 'Silver', 8, 800.0, 1, 2, 3, 2, 'Astronaut Training', '2024-11-15', 'Great experience for kids!', 8000.0, 'Paid', '2024-11-15', 202, 24),
	(303, 3111234567, 'Platinum', 20, 3000.0, 2, 2, 10, 6, 'Satellite Technology', '2025-01-05', 'Highly engaging and fun.', 18000.0, 'Unpaid', '2025-01-05', 203, 25),
	(304, 3211231234, 'Bronze', 5, 0.0, 1, 1, 1, 2, 'Rocket Launch Sim', '2025-02-20', 'Exciting but short.', 5000.0, 'Paid', '2025-02-20', 201, 26),
	(305, 3311239876, 'Gold', 15, 2000.0, 3, 0, 6, 5, 'Moon Landing Zone', '2025-03-10', 'Very realistic simulation!', 14000.0, 'Paid', '2025-03-10', 202, 27),
	(306, 3412345678, 'Silver', 7, 700.0, 2, 1, 4, 3, 'Black Hole Experience', '2025-01-20', 'Mind-blowing visuals!', 9000.0, 'Paid', '2025-01-20', 203, 28),
    (307, 3512349876, 'Gold', 10, 1200.0, 1, 2, 5, 4, 'Space Station Tour', '2025-02-15', 'Kids loved the VR experience', 11000.0, 'Paid', '2025-02-15', 201, 29),
    (308, 3612398765, 'Platinum', 18, 2800.0, 2, 0, 8, 7, 'All Exhibits', '2025-03-05', 'Worth every penny!', 17000.0, 'Unpaid', '2025-03-05', 202, 30),
    (309, 3712387654, 'Bronze', 3, 0.0, 1, 0, 2, 1, 'Telescope Gallery', '2025-04-10', 'Educational but crowded', 3000.0, 'Paid', '2025-04-10', 203, 31),
    (310, 3812376543, 'Gold', 9, 1100.0, 2, 2, 4, 3, 'Children Space Zone', '2025-01-25', 'Perfect family outing', 10000.0, 'Paid', '2025-01-25', 209, 32),
    (311, 3912365432, 'Silver', 6, 600.0, 1, 1, 3, 2, 'Mars Rover Exhibit', '2025-02-28', 'Interactive and fun', 7000.0, 'Paid', '2025-02-28', 209, 33),
    (312, 4012354321, 'Platinum', 22, 3500.0, 3, 1, 9, 8, 'VR Space Walk', '2025-03-15', 'Best museum experience ever!', 20000.0, 'Paid', '2025-03-15', 209, 34),
    (313, 4112343210, 'Bronze', 4, 0.0, 2, 0, 1, 1, 'Astronomy Basics', '2025-04-05', 'Good for beginners', 4000.0, 'Unpaid', '2025-04-05', 209, 35),
	(314, 4212332109, 'Gold', 11, 1300.0, 1, 3, 5, 4, 'Space Camp Area', '2025-01-30', 'Kids did not want to leave!', 12500.0, 'Paid', '2025-01-30', 209, 36),
    (315, 4312321098, 'Silver', 8, 800.0, 2, 1, 4, 3, 'Solar System Tour', '2025-03-20', 'Informative and engaging', 8500.0, 'Paid', '2025-03-20', 201, 37);

INSERT INTO Exhibit (Exhibit_ID, Exhibit_Name, Location, Overseeing_Start_Date, Overseeing_End_Date, Year_Of_Exhibit, Duration_in_Minutes, Admin_ID, Visitor_ID) VALUES
	(401, 'Journey to Mars', 'Hall A - Sector 1', '2024-11-01', '2025-03-01', 2024, 60, 103, 301),
    (402, 'Satellite Lab', 'Hall B - Sector 2', '2025-01-10', '2025-06-15', 2025, 50, 103, 302),
    (403, 'Lunar Landing Simulation', 'Hall C - Sector 5', '2024-12-05', '2025-04-30', 2024, 55, 103, 304),
    (404, 'Astronaut Fitness Zone', 'Hall D - Sector 3', '2025-02-01', '2025-07-01', 2025, 40, 104, 304),
    (405, 'Deep Space Telescope', 'Hall E - Sector 4', '2025-03-20', '2025-08-20', 2025, 70, 104, 305),
    (406, 'Black Hole Experience', 'Hall F - Sector 6', '2025-04-01', '2025-09-01', 2025, 65, 104, 306),
    (407, 'Alien Life Exhibit', 'Hall G - Sector 7', '2025-05-10', '2025-10-10', 2025, 50, 104, 307),
    (408, 'Robotic Rover Showcase', 'Hall H - Sector 8', '2025-06-15', '2025-11-15', 2025, 45, 105, 304),
    (409, 'Space Weather Station', 'Hall I - Sector 9', '2025-07-20', '2025-12-20', 2025, 60, 105, 309),
    (410, 'Gravity Exploration Zone', 'Hall J - Sector 10', '2025-08-25', '2026-01-25', 2025, 55, 105, 304),
    (411, 'Mars Habitat Dome', 'Hall K - Sector 11', '2025-09-30', '2026-02-28', 2025, 50, 105, 311),
    (412, 'Comet Tracking Station', 'Hall L - Sector 12', '2025-10-05', '2026-03-05', 2025, 40, 103, 304),
    (413, 'Rocket Engine Display', 'Hall M - Sector 13', '2025-11-01', '2026-04-01', 2025, 65, 104, 313),
    (414, 'Hubble Space Telescope', 'Hall N - Sector 14', '2025-12-01', '2026-05-01', 2025, 70, 105, 314),
    (415, 'Mission Control Room', 'Hall O - Sector 15', '2026-01-01', '2026-06-01', 2026, 75, 103, 315);

INSERT INTO Projection (Projection_ID, Name, Type, Distance_from_Earth) VALUES
	-- Planets
	(1, 'Mercury', 'Planet', 77000000),
	(2, 'Venus', 'Planet', 41000000),
	(3, 'Earth', 'Planet', 0),
	(4, 'Mars', 'Planet', 78000000),
	(5, 'Jupiter', 'Planet', 628730000),
	(6, 'Saturn', 'Planet', 1275000000),
	(7, 'Uranus', 'Planet', 2724000000),
	(8, 'Neptune', 'Planet', 4351000000),
	(9, 'Pluto', 'Dwarf Planet', 5906400000),
	-- Stars
	(10, 'Sun', 'Star', 0),
	(11, 'Proxima Centauri', 'Star', 39900000000000),
	(12, 'Alpha Centauri A', 'Star', 41400000000000),
	(13, 'Alpha Centauri B', 'Star', 41400000000000),
	(14, 'Barnards Star', 'Star', 58700000000000),
	(15, 'Wolf 359', 'Star', 79000000000000),
	(16, 'Sirius', 'Star', 81400000000000),
	-- Moons
	(17, 'Moon', 'Moon', 384400),
    (18, 'Phobos', 'Moon', 9377000),
    (19, 'Deimos', 'Moon', 23460000),
    (20, 'Io', 'Moon', 628730000),
    (21, 'Europa', 'Moon', 628730000),
    (22, 'Ganymede', 'Moon', 628730000),
    (23, 'Callisto', 'Moon', 628730000),
    (24, 'Titan', 'Moon', 1275000000),
    (25, 'Amalthea', 'Moon', 628730000),
    (26, 'Enceladus', 'Moon', 1275000000),
    (27, 'Mimas', 'Moon', 1275000000),
    (28, 'Dione', 'Moon', 1275000000),
    (29, 'Tethys', 'Moon', 1275000000),
    (30, 'Charon', 'Moon', 5906400000),
    (31, 'Nix', 'Moon', 5906400000),
    (32, 'Hydra', 'Moon', 5906400000),
    (33, 'Kerberos', 'Moon', 5906400000),
    (34, 'Styx', 'Moon', 5906400000);

INSERT INTO Multimedia_Equipment (ME_ID, Name, Operational_Status, Admin_ID, Visitor_ID, Exhibit_ID, Projection_ID) VALUES
	(501, 'Deep Space VR Rig', 'Operational', 106, 301, 405, 5), -- Matches 'Deep Space Telescope'
	(502, 'Mars Rover Feed Display', 'Under Maintenance', 106, 302, 401, 2), -- Matches 'Journey to Mars'
	(503, 'Black Hole VR Dome', 'Operational', 106, 303, 406, 3), -- Matches 'Black Hole Experience'
	(504, 'Crew Cabin Audio Experience', 'Operational', 110, 304, 404, 4), -- Matches 'Astronaut Fitness Zone'
	(505, 'Telescope Feed Panel', 'Calibration Needed', 110, 305, 414, 1); -- Matches 'Hubble Space Telescope';


INSERT INTO Planet (Planet_ID, Orbital_Period_Days, Mass, Diameter, Discoverer, Surface_Temperature, Image_URL, Img_Description, Projection_ID) VALUES
	(701, 88, 0.330, 4879.0, 'Galileo Galilei and Thomas Harriot', 167.0, 'https://solarsystem.nasa.gov/gltf_embed/2369/', 'Mercury - Smallest planet, closest to Sun', 1),
	(702, 225, 4.87, 12104.0, 'Galileo Galilei', 464.0, 'https://solarsystem.nasa.gov/gltf_embed/2342/', 'Venus - Brightest planet, thick atmosphere', 2),
	(703, 365, 5.97, 12756.0, 'Humankind', 15.0, 'https://solarsystem.nasa.gov/gltf_embed/2393/', 'Earth - Our home planet', 3),
	(704, 687, 0.642, 6792.0, 'Galileo Galilei', -65.0, 'https://solarsystem.nasa.gov/gltf_embed/2372/', 'Mars - The red planet', 4),
	(705, 4333, 1898.0, 142984.0, 'Galileo Galilei', -110.0, 'https://solarsystem.nasa.gov/gltf_embed/2375/', 'Jupiter - The gas giant', 5),
	(706, 10759, 568.0, 120536.0, 'Galileo Galilei', -140.0, 'https://solarsystem.nasa.gov/gltf_embed/2355/', 'Saturn - Known for its rings', 6),
	(707, 30687, 86.8, 51118.0, 'William Herschel', -195.0, 'https://solarsystem.nasa.gov/gltf_embed/2344/', 'Uranus - Tilted rotation axis', 7),
	(708, 60190, 102.0, 49528.0, 'Johann Galle', -200.0, 'https://solarsystem.nasa.gov/gltf_embed/2364/', 'Neptune - Strongest winds in solar system', 8),
	(709, 90560, 0.0146, 2376.6, 'Venetia Burney', -232.0, 'https://solarsystem.nasa.gov/gltf_embed/2357/', 'Pluto - Coldest dwarf planet', 9);

INSERT INTO Moon (Moon_ID, Orbital_Period_Days, Mass, Diameter, Surface_Temperature, Planet_ID, Projection_ID) VALUES
	-- Earth
	(801, 27.3, 0.073, 3474.8, -20.0, 703, 17),  -- Moon
	-- Mars
	(802, 0.319, 1.07E-4, 22.2, -40.0, 704, 18), -- Phobos
	(803, 1.263, 1.48E-5, 12.4, -40.0, 704, 19), -- Deimos
	-- Jupiter (5 major moons)
	(804, 1.769, 0.089, 3643.2, -160.0, 705, 20), -- Io
	(805, 3.551, 0.048, 3121.6, -160.0, 705, 21), -- Europa
	(806, 7.155, 0.148, 5262.4, -160.0, 705, 22), -- Ganymede
	(807, 16.689, 0.107, 4820.6, -160.0, 705, 23), -- Callisto
	(808, 0.294, 2.5E-6, 20.0, -160.0, 705, 24), -- Amalthea
	-- Saturn (5 selected)
	(809, 15.945, 0.054, 5150.0, -180.0, 706, 25), -- Titan
	(810, 1.370, 0.000, 504.2, -180.0, 706, 26),   -- Enceladus
	(811, 0.942, 0.000, 396.0, -180.0, 706, 27),   -- Mimas
	(812, 4.518, 0.000, 1062.2, -180.0, 706, 28),  -- Dione
	(813, 2.736, 0.000, 1122.8, -180.0, 706, 29),  -- Tethys
	-- Pluto (5 known moons)
	(814, 6.387, 0.0122, 1212.0, -220.0, 709, 30), -- Charon
	(815, 24.854, 0.000003, 49.8, -220.0, 709, 31), -- Nix
	(816, 38.202, 0.000004, 43.0, -220.0, 709, 32), -- Hydra
	(817, 32.167, 0.0000002, 19.0, -220.0, 709, 33), -- Kerberos
	(818, 20.161, 0.0000001, 16.0, -220.0, 709, 34); -- Styx

INSERT INTO Star (Star_ID, Mass, Diameter, Projection_ID) VALUES
	(901, 1.0, 1391000.0, 10), -- Sun
	(902, 0.122, 200000.0, 11), -- Proxima Centauri
	(903, 1.1, 1690000.0, 12), -- Alpha Centauri A
	(904, 0.907, 1200000.0, 13), -- Alpha Centauri B
	(905, 0.144, 196000.0, 14), -- Barnard's Star
	(906, 0.09, 141000.0, 15), -- Wolf 359
	(907, 2.02, 2400000.0, 16); -- Sirius


-------------------------------------------------------------------------QUERIES-------------------------------------------------------------------------


SELECT * FROM Users;
SELECT * FROM Administration;
SELECT * FROM Employee;
SELECT * FROM Visitor;
SELECT * FROM Exhibit;
SELECT * FROM Projection;
SELECT * FROM Multimedia_Equipment;
SELECT * FROM Planet;
SELECT * FROM Moon;
SELECT * FROM Star;


-------------------------------------------------------------------------ADMINISTRATION-------------------------------------------------------------------------

--1.List all administrators' IDs, their roles, names, and emails by joining the Administration and Users tables.
SELECT A.Admin_ID, A.Admin_Role, U.Name, U.Email
FROM Administration A
Join Users U ON A.User_ID = U.User_ID;

--2.Display the names and roles of all admins who are assigned more than 3 exhibits
SELECT U.Name, A.Admin_Role
FROM Administration A
JOIN Users U ON A.User_ID = U.User_ID
WHERE A.Assigned_Exhibits > 3

--3.Find users whose emails belong to the space museum official domain
SELECT Name, Email,
    CASE 
        WHEN Email LIKE '%@spacemuseum.com' THEN 'Official Domain'
        ELSE 'External Domain'
    END AS Email_Type
FROM Users;

--4.For each admin role, calculate the average number of weekly working hours.
SELECT Admin_Role, AVG(Weekly_Hours) AS Avg_Weekly_Hours
FROM Administration
GROUP BY Admin_Role;

--5.Find the name of the admin who has the highest number of assigned exhibits.
SELECT TOP 1 U.Name, A.Assigned_Exhibits
FROM Administration A
JOIN Users U ON A.User_ID = U.User_ID
ORDER BY A.Assigned_Exhibits DESC;

--6.List all admin names and their approval limits where the approval limit is more than the average approval limit of all admins.
SELECT U.Name, A.Approval_Limit_Rs
FROM Administration A
JOIN Users U ON A.User_ID = U.User_ID
WHERE A.Approval_Limit_Rs > (
    SELECT AVG(Approval_Limit_Rs)
    FROM Administration
);

--7. Find all admins whose names contain the letter 'e' anywhere in their name.
SELECT U.Name, A.Admin_Role
FROM Administration A
JOIN Users U ON A.User_ID = U.User_ID
WHERE U.Name LIKE '%e%';

--8. EXHIBIT PERFORMANCE REPORT
CREATE PROCEDURE ExhibitPerformanceReport @sort_by VARCHAR(20) = 'popularity' --popularity or revenue
AS
BEGIN
    SELECT 
        e.Exhibit_ID,
        e.Exhibit_Name,
        CASE 
            WHEN e.Exhibit_Name LIKE '%VR%' OR e.Exhibit_Name LIKE '%AR%' THEN 'Interactive'
            WHEN e.Exhibit_Name LIKE '%Space%' THEN 'Space Exploration'
            ELSE 'General Astronomy'
        END AS Exhibit_Type,
        COUNT(v.Visitor_ID) AS Visitor_Count,
        AVG(e.Duration_in_Minutes) AS Avg_Duration_Minutes,
        COUNT(v.Visitor_ID) * 100.0 / (SELECT COUNT(*) FROM Visitor) AS Capacity_Utilization_Pct,
        SUM(v.Amount_Payed) AS Total_Revenue
    FROM Exhibit e
    LEFT JOIN Visitor v ON e.Visitor_ID = v.Visitor_ID
    GROUP BY e.Exhibit_ID, e.Exhibit_Name
    ORDER BY 
        CASE WHEN @sort_by = 'revenue' THEN SUM(v.Amount_Payed) ELSE COUNT(v.Visitor_ID) END DESC;
END;

-- Execute with default sorting by popularity
EXEC ExhibitPerformanceReport;

-- Execute sorting by revenue
EXEC ExhibitPerformanceReport @sort_by = 'revenue';

--9. STAFF ALLOCATION REPORT
CREATE PROCEDURE StaffAllocationReport
AS
BEGIN
    SELECT 
        u.Name AS Employee_Name,
        e.Employee_Role,
        e.Assigned_Exhibit,
        e.Weekly_Hours_Worked,
        a.Admin_Role AS Supervised_By,
        e.Assigned_Shift
    FROM Employee e
    JOIN Users u ON e.User_ID = u.User_ID
    LEFT JOIN Administration a ON e.Admin_ID = a.Admin_ID
    ORDER BY e.Employee_Role, u.Name;
END;

-- Execute the report
EXEC StaffAllocationReport;

--10. MAINTENANCE ALERT REPORT
SELECT me.ME_ID, me.Name, me.Operational_Status, v.Visitor_ID, v.AR_Usage_Hours, v.VR_Usage_Hours, e.Last_Maintenance_Check_Date
FROM Multimedia_Equipment me
JOIN Visitor v ON me.Visitor_ID = v.Visitor_ID
LEFT JOIN Employee e ON v.Employee_ID = e.Employee_ID
WHERE (me.Name LIKE '%AR%' OR me.Name LIKE '%VR%' OR me.Name LIKE '%Projector%')
       AND (v.AR_Usage_Hours >= 3 OR v.VR_Usage_Hours >= 5);

--11. FINNCIAL SUMMARY REPORT
SELECT 
    ex.Exhibit_Name,
    SUM(v.Amount_Payed) AS Total_Revenue,
    SUM(COALESCE(a.Weekly_Hours, 0) * 500) + SUM(COALESCE(e.Weekly_Hours_Worked, 0) * 300) AS Estimated_Expenses,
    SUM(v.Amount_Payed) - (SUM(COALESCE(a.Weekly_Hours, 0) * 500) + SUM(COALESCE(e.Weekly_Hours_Worked, 0) * 300)) AS Profit_Loss,
    a.Approval_Limit_Rs,
    CASE 
        WHEN a.Approval_Limit_Rs >= 100000 THEN 'Highlight'
        ELSE 'Normal'
    END AS Approval_Status
FROM 
    Exhibit ex
LEFT JOIN Visitor v ON ex.Visitor_ID = v.Visitor_ID
LEFT JOIN Administration a ON ex.Admin_ID = a.Admin_ID
LEFT JOIN Employee e ON e.Assigned_Exhibit = ex.Exhibit_Name
GROUP BY 
    ex.Exhibit_Name, a.Approval_Limit_Rs;


-------------------------------------------------------------------------EMPLOYEE-------------------------------------------------------------------------

--1. List all employees with their assigned shifts and roles.
SELECT Employee_ID, Employee_Role, Assigned_Shift 
FROM Employee;

--2. Show equipment that needs maintenance.
SELECT ME_ID, Name, Operational_Status 
FROM Multimedia_Equipment 
WHERE Operational_Status != 'Operational';

--- Joins SQL Quries ---

-- Simple Join --
--3. List employees with their names, emails and roles.
Select u.Name, u.Email, e.employee_role
From Users u
JOIN Employee e
ON u.User_ID = e.User_ID;

-- Inner Join --
--4. Show employees with their supervising admin (Daily Operations Report).
SELECT e.Employee_ID, e.Employee_Role, a.Admin_ID, a.Admin_Role 
FROM Employee e
INNER JOIN Administration a ON e.Admin_ID = a.Admin_ID;

--5. List visitors handled by each employee (Visitor Log Report).
SELECT e.Employee_ID, e.Employee_Role, v.Visitor_ID, u.Name, v.Registration_Date
FROM Employee e
INNER JOIN Visitor v ON e.Employee_ID = v.Employee_ID
INNER JOIN Users u ON v.User_ID = u.User_ID;

-- Nested join 
--6. Find employees who have handled Platinum membership visitors.
SELECT Employee_ID, Employee_Role
FROM Employee
WHERE Employee_ID IN (
    SELECT Employee_ID 
    FROM Visitor 
    WHERE Membership_Tier = 'Platinum'
);

--7. List exhibits that have equipment needing maintenance (Equipment Status Report).
SELECT e.Exhibit_ID, e.Exhibit_Name, me.Name AS Equipment, me.Operational_Status
FROM Exhibit e
INNER JOIN Multimedia_Equipment me ON e.Exhibit_ID = me.Exhibit_ID
WHERE me.ME_ID IN (
    SELECT ME_ID 
    FROM Multimedia_Equipment 
    WHERE Operational_Status != 'Operational'
);

-- Wildcard SQL Queries --

--8. List employees assigned to shifts containing "ven".
Select * 
From Employee
WHERE Assigned_Shift LIKE '%ven%';

--9. List exhibits with names starting with "A" or "P".
Select * 
From Exhibit
WHERE Exhibit_Name LIKE 'A%' OR Exhibit_Name LIKE 'P%';

--- Sorting + Arithematic SQL Quries --- 

--10. Sort all employees by name alphabetically.
SELECT e.Employee_ID, u.Name, e.Employee_Role, e.Assigned_Shift
FROM Employee e
JOIN Users u ON e.User_ID = u.User_ID
ORDER BY u.Name ASC;

--11. Calculate total weekly hours worked by all employees.
SELECT SUM(Weekly_Hours_Worked) AS total_hours_worked
FROM Employee;

--12. Average weekly hours worked by all employees.
SELECT AVG(Weekly_Hours_Worked) AS avg_weekly_hours
FROM Employee;

--13. Count paid vs unpaid visitors.
SELECT 
    SUM(CASE WHEN Payment_Status = 'Paid' THEN 1 ELSE 0 END) AS paid_visitors,
    SUM(CASE WHEN Payment_Status = 'Unpaid' THEN 1 ELSE 0 END) AS unpaid_visitors,
    COUNT(*) AS total_visitors
FROM Visitor;

--14. List employees who have worked more than 38 hours per week.
SELECT Employee_ID, Employee_Role, Weekly_Hours_Worked
FROM Employee
GROUP BY Employee_ID, Employee_Role, Weekly_Hours_Worked
HAVING Weekly_Hours_Worked > 38;


--- Clause SQL Query ---
--15. List exhibits named "Satellite Lab" or "Hubble Space Telescope".
Select* From Exhibit WHERE Exhibit_Name IN ('Satellite Lab', 'Hubble Space Telescope');

--- Join with Order By Query ---
--16. List all employees with their names and roles (sorted Z-A).
SELECT u.Name, e.Employee_Role, e.Assigned_Shift
FROM Employee e
JOIN Users u ON e.User_ID = u.User_ID
ORDER BY u.Name DESC;


-------------------------------------------------------------------------VISITOR-------------------------------------------------------------------------

SELECT * FROM Exhibit;
SELECT * FROM Visitor;

-----------------------------------------------Membership Benefits Report---------------------------------------------
--1. What is my Current Membership Tier & Total Visits?
SELECT  u.Name, v.Membership_Tier
FROM Visitor v
JOIN Users u
ON v.User_ID=u.User_ID
WHERE Visitor_ID = 301;

--2. Am i eligible to any discounts?  (Ans:YES)         
--(the criteria here is that discount is given to those whose visits are more than or equal to 5)
SELECT Discount_Earned, 'You have unlocked your 20% discount!' AS Message
FROM Visitor
WHERE Visitor_ID = 301 AND Total_Visits >= 5;


--3. Am i eligible to any discounts?  (Ans:NO) 
SELECT Discount_Earned, 'You do not have enough visits to unlock your 20% dicount!' AS Message
FROM Visitor
WHERE Visitor_ID = 304 AND Total_Visits < 10;

----------------------------Personalized Visitor Summary Report-----------------------------------------------------
--4. View my basic profile.
SELECT u.Name, v.Contact_Number, v.Registration_Date, v.Creation_Date
FROM Visitor v
JOIN Users u
ON v.User_ID=u.User_ID
WHERE Visitor_ID = 302;

--5. Display if attended exhibits of specific user is ≥15 minutes.
SELECT 
	u.Name, 
	v.Total_Visits,
	e.Exhibit_Name,
	e.Year_Of_Exhibit,
	e.Duration_in_Minutes
FROM Visitor v
JOIN Users u ON v.User_ID=u.User_ID
JOIN Exhibit e ON v.Visitor_ID=e.Visitor_ID
WHERE v.Visitor_ID = 304 AND e.Duration_in_Minutes >=15;

--6. Summary of exhibits visited where duration >= 15min and used VR ≤ 3 hours in total.
SELECT
    V.Visitor_ID,
    V.Preferred_Exhibits,
    V.VR_Usage_Hours,
    E.Exhibit_ID,
    E.Exhibit_Name,
    E.Duration_in_Minutes,
    E.Overseeing_Start_Date,
    E.Overseeing_End_Date
FROM Visitor V
JOIN Exhibit E ON V.Visitor_ID=E.Visitor_ID
WHERE
	V.Visitor_ID = 313 AND
    V.VR_Usage_Hours <= 3
    AND E.Duration_in_Minutes >= 15;

-----------------------------------Feedback History Report------------------------------------------
--7. What feedbacks has a visitor given about different exihibits?
SELECT
	U.Name,
    V.Membership_Tier,
    E.Exhibit_ID,
    E.Exhibit_Name,
    V.Feedback AS Visitor_Feedback
FROM Users u
JOIN Visitor V ON u.User_ID = V.User_ID
JOIN Exhibit E ON V.Visitor_ID = E.Visitor_ID
AND U.Name='Chen Xiao Ling';

--8. What are the feedbacks given by people who have "Silver" membership?
SELECT
	U.Name,
    V.Membership_Tier,
    E.Exhibit_ID,
    E.Exhibit_Name,
    V.Feedback AS Visitor_Feedback
FROM Users u
JOIN Visitor V ON u.User_ID = V.User_ID
JOIN Exhibit E ON V.Visitor_ID = E.Visitor_ID
AND V.Membership_Tier='Silver';

--9. What feedbacks are given by the members about exibit with longest duration?
SELECT
    V.Visitor_ID,
    V.Membership_Tier,
    E.Exhibit_ID,
    E.Exhibit_Name,
    E.Duration_in_Minutes,
    V.Feedback
FROM Exhibit E
JOIN Visitor V ON E.Visitor_ID = V.Visitor_ID
WHERE E.Duration_in_Minutes = (
    SELECT MAX(Duration_in_Minutes) FROM Exhibit
);


-------------------------------------------------------------------------PROJECTION-------------------------------------------------------------------------

--1. List all planets with their information.
SELECT p.*, pl.Mass, pl.Diameter, pl.Surface_Temperature
FROM Projection p
JOIN Planet pl ON p.Projection_ID = pl.Projection_ID
ORDER BY p.Distance_from_Earth;

--2. Find moons with diameter larger than 4000 km.
SELECT m.Moon_ID, p.Name AS Planet, m.Diameter, m.Surface_Temperature
FROM Moon m
JOIN Planet pl ON m.Planet_ID = pl.Planet_ID
JOIN Projection p ON pl.Projection_ID = p.Projection_ID
WHERE m.Diameter > 4000
ORDER BY m.Diameter DESC;

--3. Show stars and their distance from Earth
SELECT p.Name, p.Distance_from_Earth, s.Mass, s.Diameter
FROM Projection p
JOIN Star s ON p.Projection_ID = s.Projection_ID
ORDER BY p.Distance_from_Earth;

--4. Find planets with moons
SELECT p.Name AS Planet, COUNT(m.Moon_ID) AS Moon_Count
FROM Projection p
JOIN Planet pl ON p.Projection_ID = pl.Projection_ID
LEFT JOIN Moon m ON pl.Planet_ID = m.Planet_ID
GROUP BY p.Name
HAVING COUNT(m.Moon_ID) > 0
ORDER BY Moon_Count DESC;

--5. Create procedure to just get planet names.
CREATE PROCEDURE GetPlanetNames
AS
    SELECT p.Name AS PlanetName
	FROM Projection p
    JOIN Planet pl ON p.Projection_ID = pl.Projection_ID
    WHERE p.Type = 'Planet'
    ORDER BY p.Name;

-- Execute the procedure
EXEC GetPlanetNames;

--6. Get all planets with their image URLs and descriptions.
SELECT p.Name AS Planet, p.Type, pl.Image_URL, pl.Img_Description, pl.Surface_Temperature, pl.Diameter
FROM Projection p
JOIN Planet pl ON p.Projection_ID = pl.Projection_ID
ORDER BY p.Distance_from_Earth;

--7. Show planets with their discoverers and discovery methods.
SELECT p.Name AS Planet, pl.Discoverer,
    CASE 
        WHEN p.Name IN ('Mercury', 'Venus', 'Mars', 'Jupiter', 'Saturn') 
            THEN 'Ancient Observation'
        WHEN p.Name = 'Uranus' THEN 'Telescope Discovery'
        WHEN p.Name = 'Neptune' THEN 'Mathematical Prediction'
        WHEN p.Name = 'Pluto' THEN 'Systematic Search'
        ELSE 'Unknown'
    END AS Discovery_Method, pl.Image_URL
FROM Projection p
JOIN Planet pl ON p.Projection_ID = pl.Projection_ID

--8. Find planets with surface temperature suitable for humans (-50°C to 50°C)
SELECT 
    p.Name AS Planet,
    pl.Surface_Temperature,
    pl.Image_URL,
    CASE 
        WHEN pl.Surface_Temperature BETWEEN -75 AND 100 THEN 'Potentially Habitable'
        ELSE 'Extreme Conditions'
    END AS Habitability
FROM Projection p
JOIN Planet pl ON p.Projection_ID = pl.Projection_ID
WHERE pl.Surface_Temperature BETWEEN -75 AND 100
ORDER BY pl.Surface_Temperature;