package pt.upskill.projeto_sinc.models;

public enum Technology {
    //IT
    JAVA("Java"),
    PYTHON("Phyton"),
    JAVASCRIPT("JavaScript"),
    PHP("PHP"),
    RUBY("Ruby"),
    //Marketing
    PHOTOSHOP("Photoshop"),
    ILLUSTRATOR("Illustrator"),
    ANALYTICS("Analytics"),
    SOCIALMEDIA("Social Media"),
    //Finance
    SAP("SAP"),
    EXCEL("Excel"),
    QUICKBOOKS("QuickBooks"),
    SAGE("Sage"),
    //HR
    WORKDAY("Workday"),
    BAMBOO("Bamboo"),
    ADP("ADP"),
    //Legal
    LEGALONE("LegalOne"),
    PROJURIS("Projuris"),
    ESAJ("ESAJ"),
    //Management
    MSPROJECT("MsProject"),
    TRELLO("Trello"),
    JIRA("Jira"),
    // Executive
    POWERBI("PowerBi"),
    TABLEAU("Tableau"),
    SALESFORCE("SalesForce");
    private String technology;

    Technology(String technology){
        this.technology = technology;
    }

    public String getTechnology() {
        return technology;
    }
    @Override
    public String toString(){
        return technology;}

}