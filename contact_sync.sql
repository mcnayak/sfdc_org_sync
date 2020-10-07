DECLARE 
  oldxmlbinary varchar;
 BEGIN
     -- save old value
     oldxmlbinary := get_xmlbinary();
     -- change value base64 to ensure writing to _trigger_log is enabled
    SET LOCAL xmlbinary TO 'base64';

     IF new.phone != old.phone THEN
          UPDATE schematest.contact 
          SET phone = new.phone, contact_uid__c=1
          WHERE email = old.email;
     END IF; 

     -- Reset the value
     EXECUTE 'SET LOCAL xmlbinary TO ' || oldxmlbinary;
     RETURN NEW;
 END;
