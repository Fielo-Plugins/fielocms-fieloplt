<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>ApprovedEmail</fullName>
        <description>Approved Email</description>
        <protected>false</protected>
        <recipients>
            <field>FieloPLT__Email__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>FieloPLT__FieloTemplates/RegistrationApproved</template>
    </alerts>
    <alerts>
        <fullName>FieloPLT__Recomend</fullName>
        <description>send recomend mail</description>
        <protected>false</protected>
        <recipients>
            <field>FieloPLT__Email__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>FieloPLT__FieloTemplates/FieloPLT__Recomend</template>
    </alerts>
    <alerts>
        <fullName>FieloPLT__Welcome_Email</fullName>
        <description>Welcome Email</description>
        <protected>false</protected>
        <recipients>
            <field>FieloPLT__Email__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>FieloPLT__FieloTemplates/FieloPLT__Welcome</template>
    </alerts>
    <alerts>
        <fullName>Registration_Program_Default</fullName>
        <description>Registration Program Default</description>
        <protected>false</protected>
        <recipients>
            <field>FieloPLT__Email__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>FieloPLT__FieloTemplates/Register</template>
    </alerts>
    <fieldUpdates>
        <fullName>DeleteApprovedEmail</fullName>
        <description>Delete the recent email record of Approved Type sended</description>
        <field>FieloPLT__Deleted__c</field>
        <literalValue>1</literalValue>
        <name>DeleteApprovedEmail</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>DeleteRegisterEmail</fullName>
        <description>Delete the recent email record of Register Type sended</description>
        <field>FieloPLT__Deleted__c</field>
        <literalValue>1</literalValue>
        <name>DeleteRegisterEmail</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>FieloPLT__DeleteEmail</fullName>
        <field>FieloPLT__Deleted__c</field>
        <literalValue>1</literalValue>
        <name>Delete Email</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>FieloPLT__DeleteWelcomeEmail</fullName>
        <description>Delete the recent email record of Welcome Type sended</description>
        <field>FieloPLT__Deleted__c</field>
        <literalValue>1</literalValue>
        <name>DeleteWelcomeEmail</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>FieloPLT__Recomend</fullName>
        <actions>
            <name>FieloPLT__Recomend</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>FieloPLT__DeleteEmail</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>FieloPLT__Email__c.FieloPLT__Type__c</field>
            <operation>equals</operation>
            <value>Recommend</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>FieloPLT__Welcome Email</fullName>
        <actions>
            <name>FieloPLT__Welcome_Email</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>FieloPLT__DeleteWelcomeEmail</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>FieloPLT__Email__c.FieloPLT__Type__c</field>
            <operation>equals</operation>
            <value>Welcome</value>
        </criteriaItems>
        <description>&apos;Welcome&apos; Email sent to members after registration when doesn&apos;t exist site</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Registration Approved Program Default</fullName>
        <actions>
            <name>ApprovedEmail</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>DeleteApprovedEmail</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>FieloPLT__Email__c.FieloPLT__Type__c</field>
            <operation>equals</operation>
            <value>Approved</value>
        </criteriaItems>
        <description>Workflow Email to finish the Registration process for program Default after members were approved</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Registration Program Default</fullName>
        <actions>
            <name>Registration_Program_Default</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>DeleteRegisterEmail</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>FieloPLT__Email__c.FieloPLT__Type__c</field>
            <operation>equals</operation>
            <value>Register</value>
        </criteriaItems>
        <description>Workflow Email to finish the Registration process for program Default</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
