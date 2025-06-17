create database CodingChallenge

CREATE TABLE Artists ( 
ArtistID INT PRIMARY KEY, 
Name VARCHAR(255) NOT NULL, 
Biography TEXT, 
Nationality VARCHAR(100)); 
CREATE TABLE Categories ( 
CategoryID INT PRIMARY KEY, 
Name VARCHAR(100) NOT NULL); 
CREATE TABLE Artworks ( 
ArtworkID INT PRIMARY KEY, 
Title VARCHAR(255) NOT NULL, 
ArtistID INT, 
CategoryID INT, 
Year INT, 
Description TEXT, 
ImageURL VARCHAR(255), 
FOREIGN KEY (ArtistID) REFERENCES Artists (ArtistID), 
FOREIGN KEY (CategoryID) REFERENCES Categories (CategoryID)); 
CREATE TABLE Exhibitions ( 
ExhibitionID INT PRIMARY KEY, 
Title VARCHAR(255) NOT NULL, 
StartDate DATE, 
EndDate DATE, 
Description TEXT); 
CREATE TABLE ExhibitionArtworks ( 
ExhibitionID INT, 
ArtworkID INT, 
PRIMARY KEY (ExhibitionID, ArtworkID), 
FOREIGN KEY (ExhibitionID) REFERENCES Exhibitions (ExhibitionID), 
FOREIGN KEY (ArtworkID) REFERENCES Artworks (ArtworkID)); 


INSERT INTO Artists (ArtistID, Name, Biography, Nationality) VALUES 
(1, 'Pablo Picasso', 'Renowned Spanish painter and sculptor.', 'Spanish'), 
(2, 'Vincent van Gogh', 'Dutch post-impressionist painter.', 'Dutch'), 
(3, 'Leonardo da Vinci', 'Italian polymath of the Renaissance.', 'Italian'); 
INSERT INTO Categories (CategoryID, Name) VALUES 
(1, 'Painting'), 
(2, 'Sculpture'), 
(3, 'Photography'); 
INSERT INTO Artworks (ArtworkID, Title, ArtistID, CategoryID, Year, Description, ImageURL) VALUES 
(1, 'Starry Night', 2, 1, 1889, 'A famous painting by Vincent van Gogh.', 'starry_night.jpg'), 
(2, 'Mona Lisa', 3, 1, 1503, 'The iconic portrait by Leonardo da Vinci.', 'mona_lisa.jpg'), 
(3, 'Guernica', 1, 1, 1937, 'Pablo Picasso/s powerful anti-war mural.', 'guernica.jpg');
INSERT INTO Exhibitions (ExhibitionID, Title, StartDate, EndDate, Description) VALUES 
(1, 'Modern Art Masterpieces', '2023-01-01', '2023-03-01', 'A collection of modern art masterpieces.'), 
(2, 'Renaissance Art', '2023-04-01', '2023-06-01', 'A showcase of Renaissance art treasures.');
INSERT INTO ExhibitionArtworks (ExhibitionID, ArtworkID) VALUES 
(1, 1), 
(1, 2), 
(1, 3), 
(2, 2);

select * from Artists
select * from Artworks
select * from Categories
select * from ExhibitionArtworks
select * from Exhibitions

1)
select a.name,count(aw.ArtworkID) from Artists a JOIN  Artworks aw on a.ArtistID=aw.ArtistID  
group by a.name
order by count( aw.ArtworkID) desc
2)
select Title from Artworks aw JOIN Artists a on a.ArtistID=aw.ArtistID where a.Nationality like 'S%' OR a.Nationality like'D%'
order by aw.Year  asc

3)
select a.name as ArtistName,count(aw.ArtworkID) AS PaintingCount from Artists a join Artworks aw on  a.ArtistID=aw.ArtistID join Categories c
on aw.CategoryID=c.CategoryID where c.Name='Painting' group by a.name
4)
select 
    aw.Title AS ArtworkTitle,
    a.Name AS ArtistName,
    c.Name AS CategoryName
from Exhibitions e
JOIN ExhibitionArtworks ea ON e.ExhibitionID = ea.ExhibitionID
JOIN Artworks aw ON ea.ArtworkID = aw.ArtworkID
JOIN Artists a ON aw.ArtistID = a.ArtistID
JOIN Categories c ON aw.CategoryID = c.CategoryID
Where e.Title = 'Modern Art Masterpieces';

5)
select  
    a.Name AS ArtistName,
    COUNT(aw.ArtworkID) AS ArtworkCount
from Artists a
JOIN Artworks aw ON a.ArtistID = aw.ArtistID
group by a.Name
having count(aw.ArtworkID) > 2;

6)
select aw.Title  from Artworks aw join ExhibitionArtworks ex on ex.ArtworkID=aw.ArtworkID 
join Exhibitions e on e.ExhibitionID=ex.ExhibitionID  where e.Title= 'Modern Art Masterpieces' or e.Title='Renaissance Art' 
7)
select 
    c.Name AS CategoryName,
    COUNT(aw.ArtworkID) AS TotalArtworks
from Categories c
LEFT JOIN Artworks aw ON c.CategoryID = aw.CategoryID
group by c.Name;
8)
select
    a.Name AS ArtistName,
    COUNT(aw.ArtworkID) AS ArtworkCount
from Artists a
JOIN Artworks aw ON a.ArtistID = aw.ArtistID
group  by a.Name
having COUNT(aw.ArtworkID) > 3
9)
 
select aw.Title,a.name as ArtistName from Artworks aw join Artists a on a.ArtistID=aw.ArtistID where Nationality='Spanish'

10)  
select e.Title as Exhibitions from Exhibitions e join ExhibitionArtworks ex on ex.ExhibitionID=e.ExhibitionID 
join Artworks aw on aw.ArtworkID=ex.ArtworkID 
join Artists a on a.ArtistID=aw.ArtistID
WHERE a.Name IN ('Vincent van Gogh', 'Leonardo da Vinci')
GROUP BY e.ExhibitionID, e.Title
HAVING COUNT(DISTINCT a.Name) = 2;

11)
select  
    aw.Title AS ArtworkTitle
from  Artworks aw
LEFT JOIN ExhibitionArtworks ea ON aw.ArtworkID = ea.ArtworkID
where ea.ExhibitionID IS NULL;

12)
   select a.name as ArtistName from Artists a join Artworks aw on a.ArtistID=aw.ArtistID
  join Categories C on c.CategoryID=aw.CategoryID
  GROUP BY a.name,aw.ArtistID
  having count(aw.CategoryID)=(select COUNT(*) FROM Categories)

13) 
select count(aw.CategoryID) AS TotalCount ,c.name as Category from Artworks aw right join Categories c 
on c.CategoryID=aw.CategoryID
group by c.Name

14)REPEATED QUESTION (5)

15)
select
    c.Name AS CategoryName,
    AVG(aw.Year) AS AverageArtworkYear
from Categories c
join  Artworks aw ON c.CategoryID = aw.CategoryID
group by c.CategoryID, c.Name
having count(aw.ArtworkID) > 1;

16)

 select aw.Title from Artworks aw join ExhibitionArtworks ex on ex.ArtworkID=aw.ArtworkID
 join Exhibitions e on e.ExhibitionID=ex.ExhibitionID
 where e.Title='Modern Art Masterpieces'


 17)
 select  
    c.Name AS CategoryName,
    AVG(aw.Year) AS AverageYearInCategory
from Categories c
JOIN Artworks aw ON c.CategoryID = aw.CategoryID
group by c.CategoryID, c.Name
having AVG(aw.Year) > (
    select AVG(Year) FROM Artworks
)
18)REPEATED QUESTION(11)

19)
select  a.Name AS ArtistName
from  Artists a
JOIN Artworks aw ON a.ArtistID = aw.ArtistID
where aw.CategoryID = (
    select CategoryID
    from Artworks
    where Title = 'Mona Lisa'
)
20) 

select 
    a.name as artistname,
    count(aw.Artworkid) as Artworkcount
from artists a
left join artworks aw on a.ArtistID = aw.ArtworkID
group by a.ArtistID, a.name;
