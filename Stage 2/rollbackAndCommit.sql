UPDATE Volunteer
Set City = 'Ashdod'
Where Volunteer_ID = 106107388;

ROLLBACK;

UPDATE Volunteer
Set City = 'Ashdod'
Where Volunteer_ID = 106107388;

COMMIT;