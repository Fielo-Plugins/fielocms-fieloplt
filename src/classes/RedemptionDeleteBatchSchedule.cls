public class RedemptionDeleteBatchSchedule Implements Database.Batchable<sObject> , Schedulable{

    public void execute(SchedulableContext SC) {
        RedemptionDeleteBatchSchedule b = new RedemptionDeleteBatchSchedule();
        Database.executeBatch(b);
    }

    public Database.QueryLocator start(Database.BatchableContext BC){

        Date evaluationDate = date.today();
        List<Program__c> programs = new ProgramsSelector(new Set<String>{'OpenRedemptionDays__c'}).selectAll();

        Integer maxOpenDays;
        for(Program__c p : programs){
            if(p.OpenRedemptionDays__c != null && (maxOpenDays == null || p.OpenRedemptionDays__c > maxOpenDays)){
                maxOpenDays = (Integer)p.OpenRedemptionDays__c;
            }
        }

        if(maxOpenDays != null){
            evaluationDate.addDays(maxOpenDays * -1);
        }
        return Database.getQueryLocator([SELECT Id, Name,Status__c, Points__c, CreatedDate, Member__r.Program__c FROM Redemption__c WHERE Status__c = 'Open' AND CreatedDate <: evaluationDate]);
    }

    public void execute(Database.BatchableContext BC, List<sObject> scope){
        Map<Id,Program__c> programsMap = new Map<Id,Program__c>(new ProgramsSelector(new Set<String>{'OpenRedemptionDays__c'}).selectAll());
        List<Redemption__c> recordsToDelete = new List<Redemption__c>();
        for(Redemption__c r : (List<Redemption__c>)scope){
            Program__c program = programsMap.get(r.Member__r.Program__c);
            if((Integer)program.OpenRedemptionDays__c != null){
                if(r.CreatedDate < date.today().addDays((Integer)program.OpenRedemptionDays__c * -1)){
                    recordsToDelete.add(r);
                }
            }
        }
        Database.delete(recordsToDelete,false);
    }

    public void finish(Database.BatchableContext BC){}
}