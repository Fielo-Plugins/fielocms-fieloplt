<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Approved_Email</fullName>
        <description>Approved Email</description>
        <protected>false</protected>
        <recipients>
            <field>FieloPLT__Email__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>FieloPLT__Fielo_Templates/Registration_Approved</template>
    </alerts>
    <alerts>
        <fullName>FieloPLT__WelcomeEmail</fullName>
        <description>Welcome Email</description>
        <protected>false</protected>
        <recipients>
            <field>FieloPLT__Email__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>FieloPLT__Fielo_Templates/FieloPLT__Welcome_Email</template>
    </alerts>
    <alerts>
        <fullName>Registration</fullName>
        <description>Registration</description>
        <protected>false</protected>
        <recipients>
            <field>FieloPLT__Email__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>FieloPLT__Fielo_Templates/Register</template>
    </alerts>
    <rules>
        <fullName>FieloPLT__Welcome Email</fullName>
        <actions>
            <name>FieloPLT__WelcomeEmail</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <description>&apos;Welcome&apos; Email sent to members after registration when doesn&apos;t exist site</description>
        <formula>(true)</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Registration</fullName>
        <actions>
            <name>Registration</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>FieloPLT__Member__c.FieloPLT__Status__c</field>
            <operation>equals</operation>
            <value>Pending User</value>
        </criteriaItems>
        <description>Workflow Email to finish the Registration process</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Registration Approved</fullName>
        <actions>
            <name>Approved_Email</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>FieloPLT__Member__c.FieloPLT__Status__c</field>
            <operation>equals</operation>
            <value>Active</value>
        </criteriaItems>
        <description>Workflow Email to finish the Registration process after members were approved</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
