// This is a test harness for your module
// You should do something interesting in this harness 
// to test out the module and to provide instructions 
// to users on how to use it by example.


// open a single window
var win = Ti.UI.createWindow({
	backgroundColor:'white'
});
var label = Ti.UI.createLabel();
win.add(label);
win.open();

// ------------------------------------

var Mobeelizer = require('ti.mobeelizer.sdk');

Ti.API.info("##### 1 module is => " + Mobeelizer);

// ------------------------------------

Mobeelizer.registerSyncStatusListener(function(e) {
    Ti.API.info("sync status listener " + e.status);
});

// ------------------------------------

var loggedIn = Mobeelizer.isLoggedIn();

if(loggedIn) {
    throw "##### 2 user should not be logged in";
} else {
    Ti.API.info("##### 2 user is not logged in");
}

var status = Mobeelizer.loginAndWait("user", "invalid-password");

if(status == Mobeelizer.LOGIN_OK) {
    throw "##### 3 invalid login status, should not be OK => " + status;
} else {
    Ti.API.info("##### 3 valid login status");
}

var status = Mobeelizer.loginAndWait("user", "password");

if(status != Mobeelizer.LOGIN_OK) {
    throw "##### 4 invalid login status, should be OK => " + status;
} else {
    Ti.API.info("##### 4 valid login status");
}

var loggedIn = Mobeelizer.isLoggedIn();

if(!loggedIn) {
    throw "##### 5 user should be logged in";
} else {
    Ti.API.info("##### 5 user is logged in");
}

Mobeelizer.logout();

var loggedIn = Mobeelizer.isLoggedIn();

if(loggedIn) {
    throw "##### 6 user should not be logged in";
} else {
    Ti.API.info("##### 6 user is not logged in");
}

var status = Mobeelizer.loginToInstanceAndWait("test", "user", "password");

if(status != Mobeelizer.LOGIN_OK) {
    throw "##### 7 invalid login status, should be OK => " + status;
} else {
    Ti.API.info("##### 7 valid login status");
}

// ------------------------------------

var status = Mobeelizer.checkSyncStatus()

if(status != Mobeelizer.SYNC_FINISHED_WITH_SUCCESS) {
    throw "##### 8 invalid sync status, should be FINISHED_WITH_SUCCESS => " + status;
} else {
    Ti.API.info("##### 8 valid sync status");
}

var status = Mobeelizer.syncAllAndWait();

if(status != Mobeelizer.SYNC_FINISHED_WITH_SUCCESS) {
    throw "##### 9 invalid sync status, should be FINISHED_WITH_SUCCESS => " + status;
} else {
    Ti.API.info("##### 9 valid sync status");
}

var status = Mobeelizer.syncAndWait();

if(status != Mobeelizer.SYNC_FINISHED_WITH_SUCCESS) {
    throw "##### 10 invalid sync status, should be FINISHED_WITH_SUCCESS => " + status;
} else {
    Ti.API.info("##### 10 valid sync status");
}

// ------------------------------------

var status = Mobeelizer.registerForRemoteNotifications("TODO");

if(status != Mobeelizer.COMMUNICATION_SUCCESS) {
    throw "##### 11 invalid communitation status, should be SUCCESS => " + status;
} else {
    Ti.API.info("##### 11 valid communication status");
}

var status = Mobeelizer.unregisterForRemoteNotifications();

if(status != Mobeelizer.COMMUNICATION_SUCCESS) {
    throw "##### 12 invalid communitation status, should be SUCCESS => " + status;
} else {
    Ti.API.info("##### 12 valid communication status");
}

var status = Mobeelizer.sendRemoteNotification({ message: "test" });

if(status != Mobeelizer.COMMUNICATION_SUCCESS) {
    throw "##### 13 invalid communitation status, should be SUCCESS => " + status;
} else {
    Ti.API.info("##### 13 valid communication status");
}

var status = Mobeelizer.sendRemoteNotificationToDevice({ message: "test" }, "mobile" );

if(status != Mobeelizer.COMMUNICATION_SUCCESS) {
    throw "##### 14 invalid communitation status, should be SUCCESS => " + status;
} else {
    Ti.API.info("##### 14 valid communication status");
}

var status = Mobeelizer.sendRemoteNotificationToUsers({ message: "test" }, ["user", "user2"] );

if(status != Mobeelizer.COMMUNICATION_SUCCESS) {
    throw "##### 15 invalid communitation status, should be SUCCESS => " + status;
} else {
    Ti.API.info("##### 15 valid communication status");
}

var status = Mobeelizer.sendRemoteNotificationToUsersOnDevice({ message: "test" }, ["user", "user2"], "mobile" );

if(status != Mobeelizer.COMMUNICATION_SUCCESS) {
    throw "##### 16 invalid communitation status, should be SUCCESS => " + status;
} else {
    Ti.API.info("##### 16 valid communication status");
}

var status = Mobeelizer.sendRemoteNotificationToGroup({ message: "test" }, "users" );

if(status != Mobeelizer.COMMUNICATION_SUCCESS) {
    throw "##### 17 invalid communitation status, should be SUCCESS => " + status;
} else {
    Ti.API.info("##### 17 valid communication status");
}

var status = Mobeelizer.sendRemoteNotificationToGroupOnDevice({ message: "test" }, "users", "mobile" );

if(status != Mobeelizer.COMMUNICATION_SUCCESS) {
    throw "##### 18 invalid communitation status, should be SUCCESS => " + status;
} else {
    Ti.API.info("##### 18 valid communication status");
}

// ------------------------------------

var MobeelizerDatabase = Mobeelizer.getDatabase();

Ti.API.info("##### 19 database is => " + MobeelizerDatabase);

MobeelizerDatabase.removeAll("simpleSyncEntity");

var Entity1 = MobeelizerDatabase.entity("simpleSyncEntity"); 
Entity1.putField("title", "Xmen");

if(Entity1.getGuid()) {
    throw "##### 20 guid is not null";
}

var Errors = MobeelizerDatabase.save(Entity1);

if(!Errors.isValid()) {
    throw "##### 21 entity hasn't been saved, validation errors";
} else {
    Ti.API.info("##### 21 entity has been saved");
}

if(!Entity1.getGuid()) {
    throw "##### 22 guid is null";
}

if(!Entity1.getOwner()) {
    throw "##### 22 owner is null";
}

if(!Entity1.isModified()) {
    throw "##### 22 should be modified";
}

if(Entity1.isDeleted()) {
    throw "##### 22 should not be deleted";
}

if(Entity1.isConflicted()) {
    throw "##### 22 should not be conflicted";
}

var Entity2 = MobeelizerDatabase.entity("simpleSyncEntity"); 

Entity2.putField("title", "hurra2");

var Errors = MobeelizerDatabase.save(Entity2);

if(!Errors.isValid()) {
    throw "##### 23 entity hasn't been saved, validation errors";
} else {
    Ti.API.info("##### 23 entity has been saved");
}

var Entity3 = MobeelizerDatabase.entity("simpleSyncEntity"); 

Entity3.putField("title", "hurra3");

var Errors = MobeelizerDatabase.save(Entity3);

if(!Errors.isValid()) {
    throw "##### 24 entity hasn't been saved, validation errors";
} else {
    Ti.API.info("##### 24 entity has been saved");
}

var List = MobeelizerDatabase.list("simpleSyncEntity");

if(List.length != 3) {
    throw "##### 25 invalid list size, should be 3 => " + List.length;   
} else {
    Ti.API.info("##### 25 valid list size");
}

var Entity4 = MobeelizerDatabase.findOne("simpleSyncEntity", Entity1.getGuid());

if(!Entity4 || Entity4.getGuid() != Entity1.getGuid()) {
    throw "##### 26 invalid get result, should be Entity1 => " + Entity4;
} else {
    Ti.API.info("##### 26 valid get result");
}

var Exists = MobeelizerDatabase.exists("simpleSyncEntity", Entity1.getGuid());

if(!Exists) {
    throw "##### 27 should exists";
} else {
    Ti.API.info("##### 27 exist");
}

var Count = MobeelizerDatabase.count("simpleSyncEntity");

if(Count != 3) {
    throw "##### 28 invalid count, should be 3 => " + Count;   
} else {
    Ti.API.info("##### 28 valid count");
}

var Exists = MobeelizerDatabase.exists("simpleSyncEntity", "not-exists");

if(Exists) {
    throw "##### 29 should not exists";   
} else {
    Ti.API.info("##### 29 not exist");
}

var Entity5 = MobeelizerDatabase.findOne("simpleSyncEntity", "not-exists");

if(Entity5) {
    throw "##### 30 should not exits";   
} else {
    Ti.API.info("##### 30 not exist");
}

var status = Mobeelizer.syncAndWait();

if(status != Mobeelizer.SYNC_FINISHED_WITH_SUCCESS) {
    throw "##### 31 invalid sync status, should be FINISHED_WITH_SUCCESS => " + status;
} else {
    Ti.API.info("##### 31 valid sync status");
}

MobeelizerDatabase.remove("simpleSyncEntity", Entity1.getGuid());

MobeelizerDatabase.save(Entity2);

MobeelizerDatabase.removeObject(Entity2);

var Count = MobeelizerDatabase.count("simpleSyncEntity");

if(Count != 1) {
    throw "##### 32 invalid count, should be 1 => " + Count;   
} else {
    Ti.API.info("##### 32 valid count");
}

MobeelizerDatabase.removeAll("simpleSyncEntity");

var Count = MobeelizerDatabase.count("simpleSyncEntity");

if(Count != 0) {
    throw "##### 33 invalid count, should be 0 => " + Count;   
} else {
    Ti.API.info("##### 33 valid count");
}

var status = Mobeelizer.syncAllAndWait();

if(status != Mobeelizer.SYNC_FINISHED_WITH_SUCCESS) {
    throw "##### 34 invalid sync status, should be FINISHED_WITH_SUCCESS => " + status;
} else {
    Ti.API.info("##### 34 valid sync status");
}

var Count = MobeelizerDatabase.count("simpleSyncEntity");

if(Count == 0) {
    throw "##### 35 invalid count, should not be 0 => " + Count;   
} else {
    Ti.API.info("##### 35 valid count");
}

// ------------------------------------

MobeelizerDatabase.removeAll("fileSyncEntity")

var MobeelizerFile = Mobeelizer.createFile("name", Ti.Filesystem.getFile('application.xml').read());

var Entity6 = MobeelizerDatabase.entity("fileSyncEntity"); 

Entity6.putField("photo", MobeelizerFile);

var Errors = MobeelizerDatabase.save(Entity6);

if(!Errors.isValid()) {
    throw "##### 36 entity hasn't been saved, validation errors";
} else {
    Ti.API.info("##### 36 entity has been saved");
}

if(!Entity6.getField("photo").getGuid()) {
    throw "##### 37 file guid is null";
}

var Entity7 = MobeelizerDatabase.findOne("fileSyncEntity", Entity6.getGuid());

if(Entity6.getField("photo").getGuid() != Entity7.getField("photo").getGuid()) {
    throw "##### 38 differend file guid";   
}

if(Entity6.getField("photo").getName() != Entity7.getField("photo").getName()) {
    throw "##### 39 differend file name";   
}

if(Entity6.getField("photo").getStream().text != Entity7.getField("photo").getStream().text) {
    throw "##### 40 differend file stream";   
}

var MobeelizerFile2 = Mobeelizer.getExistingFile("name", Entity6.getField("photo").getGuid());

if(Entity6.getField("photo").getStream().text != MobeelizerFile2.getStream().text) {
    throw "##### 41 differend file stream";   
}

var status = Mobeelizer.syncAndWait();

if(status != Mobeelizer.SYNC_FINISHED_WITH_SUCCESS) {
    throw "##### 42 invalid sync status, should be FINISHED_WITH_SUCCESS => " + status;
} else {
    Ti.API.info("##### 42 valid sync status");
}

MobeelizerDatabase.removeAll("fileSyncEntity");

var status = Mobeelizer.syncAllAndWait();

if(status != Mobeelizer.SYNC_FINISHED_WITH_SUCCESS) {
    throw "##### 43 invalid sync status, should be FINISHED_WITH_SUCCESS => " + status;
} else {
    Ti.API.info("##### 43 valid sync status");
}

var Entity8 = MobeelizerDatabase.findOne("fileSyncEntity", Entity6.getGuid());

if(Entity6.getField("photo").getGuid() != Entity8.getField("photo").getGuid()) {
    throw "##### 44 differend file guid";   
}

if(Entity6.getField("photo").getName() != Entity8.getField("photo").getName()) {
    throw "##### 45 differend file name";   
}

if(Entity6.getField("photo").getStream().text != Entity8.getField("photo").getStream().text) {
    throw "##### 46 differend file stream";   
}

// ------------------------------------

MobeelizerDatabase.removeAll("simpleSyncEntity");

var MobeelizerCriteriaBuilder = MobeelizerDatabase.find("simpleSyncEntity");

Ti.API.info("##### 47 criteria builder is => " + MobeelizerCriteriaBuilder);

var Count = MobeelizerCriteriaBuilder.count();

if(Count != 0) {
    throw "##### 48 invalid count, should be 0 => " + Count;   
} else {
    Ti.API.info("##### 48 valid count");
}

var List = MobeelizerCriteriaBuilder.list();

if(List.length != 0) {
    throw "##### 49 invalid list count, should be 0 => " + List.length;   
} else {
    Ti.API.info("##### 49 valid list count");
}

var UniqueResult = MobeelizerCriteriaBuilder.uniqueResult();

if(UniqueResult) {
    throw "##### 50 invalid unique result, should be nil => " + UniqueResult;   
} else {
    Ti.API.info("##### 50 valid unique result");
}

var Entity = MobeelizerDatabase.entity("simpleSyncEntity"); 

Entity.putField("title", "b");

var Errors = MobeelizerDatabase.save(Entity);

if(!Errors.isValid()) {
    throw "##### 51 entity hasn't been saved, validation errors";
}

var Entity = MobeelizerDatabase.entity("simpleSyncEntity"); 

Entity.putField("title", "c");

var Errors = MobeelizerDatabase.save(Entity);

if(!Errors.isValid()) {
    throw "##### 52 entity hasn't been saved, validation errors";
}

var Entity = MobeelizerDatabase.entity("simpleSyncEntity"); 

Entity.putField("title", "d");

var Errors = MobeelizerDatabase.save(Entity);

if(!Errors.isValid()) {
    throw "##### 53 entity hasn't been saved, validation errors";
}

var MobeelizerRestriction = MobeelizerDatabase.Restriction;
var MobeelizerOrder = MobeelizerDatabase.Order;

MobeelizerCriteriaBuilder.setMaxResults(1).setFirstAndMaxResults(1, 10).addOrder(MobeelizerOrder.desc("title")).addOrder(MobeelizerOrder.asc("title"));

MobeelizerCriteriaBuilder.add(MobeelizerRestriction.guidNe("123")).add(MobeelizerRestriction.ownerNe("123")).add(MobeelizerRestriction.isNotConflicted());

MobeelizerCriteriaBuilder.add(MobeelizerRestriction.ne("title", "z")).add(MobeelizerRestriction.le("title", "d")).add(MobeelizerRestriction.lt("title", "e")).add(MobeelizerRestriction.ge("title", "b")).add(MobeelizerRestriction.gt("title", "a"));

MobeelizerCriteriaBuilder.add(MobeelizerRestriction.between("title", "a", "e"));

MobeelizerCriteriaBuilder.add(MobeelizerRestriction.inArray("title", ["b", "c", "d"]));

MobeelizerCriteriaBuilder.add(MobeelizerRestriction.isNotNull("title"));

MobeelizerCriteriaBuilder.add(MobeelizerRestriction.neField("title", "_guid"));

MobeelizerCriteriaBuilder.add(MobeelizerRestriction.disjunction().add(MobeelizerRestriction.eq("title", "b")).add(MobeelizerRestriction.eq("title", "c")).add(MobeelizerRestriction.eq("title", "d")));

MobeelizerCriteriaBuilder.add(MobeelizerRestriction.createOr(MobeelizerRestriction.eq("title", "b"), MobeelizerRestriction.eq("title", "c"),MobeelizerRestriction.eq("title", "d")));

MobeelizerCriteriaBuilder.add(MobeelizerRestriction.conjunction().add(MobeelizerRestriction.ne("title", "xxx")).add(MobeelizerRestriction.ne("title", "xxx2")));

MobeelizerCriteriaBuilder.add(MobeelizerRestriction.createAnd(MobeelizerRestriction.ne("title", "xxx"), MobeelizerRestriction.ne("title", "xxx2")));

MobeelizerCriteriaBuilder.add(MobeelizerRestriction.createNot(MobeelizerRestriction.eq("title", "aaa")));

var Count = MobeelizerCriteriaBuilder.count();

if(Count != 2) {
    throw "##### 54 invalid count, should be 2 => " + Count;   
} else {
    Ti.API.info("##### 54 valid count");
}

var List = MobeelizerCriteriaBuilder.list();

if(List.length != 2) {
    throw "##### 55 invalid list count, should be 2 => " + List.length;   
} else {
    Ti.API.info("##### 55 valid list count");
}

if(List[0].getField("title") != "c" || List[1].getField("title") != "b") {
    throw "##### 56 invalid list order";
} else {
    Ti.API.info("##### 56 valid list order");    
}

MobeelizerCriteriaBuilder.setFirstAndMaxResults(0, 1);

MobeelizerCriteriaBuilder.add(MobeelizerRestriction.guidEq(Entity.getGuid())).add(MobeelizerRestriction.ownerEq(Entity.getOwner()));

MobeelizerCriteriaBuilder.add(MobeelizerRestriction.allEq({title: "d"}));

MobeelizerCriteriaBuilder.add(MobeelizerRestriction.eq("title", "d"));

MobeelizerCriteriaBuilder.add(MobeelizerRestriction.like("title", "d"));

MobeelizerCriteriaBuilder.add(MobeelizerRestriction.like("title", "d", MobeelizerRestriction.MATCH_MODE_EXACT));

var UniqueResult = MobeelizerCriteriaBuilder.uniqueResult();

if(!UniqueResult) {
    throw "##### 57 result should be null";
} else {
    Ti.API.info("##### 57 valid result");
}

MobeelizerCriteriaBuilder.add(MobeelizerRestriction.like("title", "d", MobeelizerRestriction.MATCH_MODE_END));
MobeelizerCriteriaBuilder.add(MobeelizerRestriction.like("title", "d", MobeelizerRestriction.MATCH_MODE_ANYWHERE));
MobeelizerCriteriaBuilder.add(MobeelizerRestriction.like("title", "d", MobeelizerRestriction.MATCH_MODE_START));

MobeelizerCriteriaBuilder.add(MobeelizerRestriction.isConflicted());

MobeelizerCriteriaBuilder.add(MobeelizerRestriction.isNull("title"));

MobeelizerCriteriaBuilder.add(MobeelizerRestriction.leField("title", "_guid")).add(MobeelizerRestriction.ltField("title", "_guid")).add(MobeelizerRestriction.geField("title", "_guid")).add(MobeelizerRestriction.gtField("title", "_guid")).add(MobeelizerRestriction.eqField("title", "_guid"));

var UniqueResult = MobeelizerCriteriaBuilder.uniqueResult();

if(UniqueResult) {
    throw "##### 58 result should be null";
} else {
    Ti.API.info("##### 58 valid result");
}

var MobeelizerCriteriaBuilder = MobeelizerDatabase.find("graphsConflictsItemEntity");

MobeelizerCriteriaBuilder.add(MobeelizerRestriction.belongsTo("orderGuid", "graphsConflictsOrderEntity", "123"));

var BelongsToEntity = MobeelizerDatabase.entity("graphsConflictsOrderEntity");
BelongsToEntity.setGuid("1234");

MobeelizerCriteriaBuilder.add(MobeelizerRestriction.belongsToObject("orderGuid", BelongsToEntity));

var UniqueResult = MobeelizerCriteriaBuilder.uniqueResult();

if(UniqueResult) {
    throw "##### 59 result should be null";
} else {
    Ti.API.info("##### 59 valid result");
}

// ------------------------------------

Mobeelizer.sync(function(e) { 
    if(e.status != Mobeelizer.SYNC_FINISHED_WITH_SUCCESS) {
        throw "@@@@@ 1 invalid sync status, should be FINISHED_WITH_SUCCESS => " + status;
    } else {
        Ti.API.info("@@@@@ 1 valid sync status");        
    }
                
    Mobeelizer.syncAll(function(e) { 
        if(e.status != Mobeelizer.SYNC_FINISHED_WITH_SUCCESS) {
            throw "@@@@@ 2 invalid sync status, should be FINISHED_WITH_SUCCESS => " + status;
        } else {
            Ti.API.info("@@@@@ 2 valid sync status");        
        }
                       
        Mobeelizer.login("user", "password", function(e) { 
            if(e.status != Mobeelizer.LOGIN_OK) {
                throw "@@@@@ 3 invalid login status, should be OK => " + status;
            } else {
                Ti.API.info("@@@@@ 3 valid login status");        
            }
                         
            Mobeelizer.loginToInstance("test", "user", "password", function(e) { 
                if(e.status != Mobeelizer.LOGIN_OK) {
                    throw "@@@@@ 4 invalid login status, should be OK => " + status;
                } else {
                    Ti.API.info("@@@@@ 4 valid login status");        
                }
            });
        });
    });
});

// ------------------------------------