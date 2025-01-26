import processing.svg.*;
import processing.pdf.*;
Table table;
float minLon = 24, maxLon = 37.6;
float minLat = 53.9, maxLat = 55.8; 
float minTemp = -30, maxTemp = 0;
float minSurv = 0, maxSurv = 340000; 
float chartWidth, chartHeight;

void setup() {
  //beginRecord(SVG, "C:\\Users\\arora\\Desktop\\Trinity\\Sem 1\\CS7DS4 – Data Visualisation\\Assessments\\Assignment 1\\minard_output.svg");
  //beginRecord(PDF, "C:\\Users\\arora\\Desktop\\Trinity\\Sem 1\\CS7DS4 – Data Visualisation\\Assessments\\Assignment 1\\minard_output.pdf");
  size(1123, 794);  // Set the window size
  chartWidth = width * 0.9;
  chartHeight = height * 0.9;

  table = loadTable("C:\\Users\\arora\\Desktop\\Trinity\\Sem 1\\CS7DS4 – Data Visualisation\\Assessments\\Assignment 1\\minard_data.csv", "header"); 
}

void draw() {
  background(242, 229, 191);
  // You can add more features like a border or grid lines here if desired.
  textSize(40); // Set text size for the title
  fill(0); // Set text color to black
  //textAlign(CENTER); // Center align the text
  text("Map of Napoleon's Russia Campaign", (width-500) / 2, 40);
  
  textSize(12);
  
  TableRow prevrow = null;
  float prevlont = 0.0, lont;
  float prevtemp = 0.0, temp;
  for (TableRow row : table.rows()) {
    if(Float.isNaN(row.getFloat("LONT")) || Float.isNaN(row.getFloat("TEMP")))
      {break;}
    else
    {
       lont = row.getFloat("LONT");
       temp = row.getFloat("TEMP");
       String day = row.getString("DAY");
       String month = row.getString("MON");
       
       
       float x = map(lont, minLon, maxLon, 0, chartWidth);
       float y = map(temp, minTemp, maxTemp, chartHeight* 0.95, chartHeight * 0.8);  // Lower temperature = lower y
       
    
    
      fill(128, 0, 0);
      //ellipse(x + width * 0.05, y + height * 0.05, 10, 10);
      ellipse(x + width * 0.05, y + height * 0.05, 8, 8);
      text(int(temp) + "° (" + day + " " + month + ")", x + width * 0.05, y + height * 0.05 + 30);
      
      float spacing = 10; // Distance between the dots
      strokeWeight(2); // Set the size of the points (smaller size)
      stroke(0, 0, 0, 200); // Color of the dotted line
      for (float i = y - 4; i > 0; i -= spacing) {
        point(x+ width * 0.05, i + height * 0.05); // Draws a point along the vertical line
      }
      
      if(prevrow != null){
         float x2 = map(prevlont, minLon, maxLon, 0, chartWidth);
         float y2 = map(prevtemp, minTemp, maxTemp, chartHeight* 0.95, chartHeight * 0.8);
         strokeWeight(7);
        line(x + width * 0.05, y + height * 0.05, x2 + width * 0.05, y2 + height * 0.05);
    }
    }

    prevrow = row;
    prevlont = lont;
    prevtemp = temp;
    
    float timelineX = width - 230; // Right position
    float timelineY = height - 80; // Bottom position

  // Draw the black line
    //stroke(0); // Black color
    strokeWeight(7); // Set stroke weight
    line(timelineX, timelineY, timelineX + 60, timelineY); // Draw the line
    
    // Draw text
    //fill(0); // Black text
    textSize(13); // Set text size for the timeline legend
    text("Timelines of Returning", timelineX + 70, timelineY);
    text("Divisions with temperature ", timelineX + 70, timelineY + 15);
    textSize(12);
  }
  /*TableRow previousRow = null;
  int currentDiv = -1;
  String previousDir = "";  // Store previous direction (A/R)
  int previousDiv = -1;  // Track previous division*/
  TableRow prevrow2 = null;
  float prevlonp = 0.0, lonp;
  float prevlatp = 0.0, latp;
  String prevdir="", dir;
  int prevdiv=1, div;
  
  for (TableRow row : table.rows()) {
    if(Float.isNaN(row.getFloat("LONP")) || Float.isNaN(row.getFloat("LATP")) || Float.isNaN(row.getFloat("SURV")))
      {break;}
    else
    {
    lonp = row.getFloat("LONP");
    println("lon:",lonp);
    latp = row.getFloat("LATP");
    println("lat:",latp);
    float surv = row.getFloat("SURV");
    println("SURV:",surv);
    dir = row.getString("DIR");
    println("DIR:",dir);
    div = row.getInt("DIV");
    println("DIV:",div);
    
    float x = map(lonp, minLon, maxLon, 0, chartWidth);
    float y = map(latp, minLat, maxLat, chartHeight * 0.7, 0);
    
    if (dir.equals("A") || prevdir.equals("A")) {
      if (div == 1) stroke(144, 238, 144);  
      else if (div == 2) stroke(51, 153, 102); 
      else if (div == 3)stroke(0, 102, 0); 
    } else if (dir.equals("R") ) {
      if (div == 1) stroke(253, 139, 81);  
      else if (div == 2) stroke(203, 96, 64); 
      else if (div == 3)stroke(139, 0, 0); 
    }
 
    if(prevrow2 != null && prevdiv == div){
         float x2 = map(prevlonp, minLon, maxLon, 0, chartWidth);
         float y2 = map(prevlatp, minLat, maxLat, chartHeight * 0.7, 0);
         //strokeWeight(7);
         strokeWeight(map(surv, minSurv, maxSurv, 1, 70));
        line(x + width * 0.05, y + height * 0.05, x2 + width * 0.05, y2 + height * 0.05);
        if (dir.equals("A")) {
          if (div == 1){
           pushMatrix();
          translate(x + width * 0.05 - 20, y + height * 0.05 - 20);
          rotate(-PI / 2);
          fill(0);
          text(int(surv) , 0 , 0);
          popMatrix();
          }
          if (div == 2){
            pushMatrix();
          translate(x + width * 0.05 - 10, y + height * 0.05 - 30);
          rotate(-PI / 2);
          fill(0);
          text(int(surv) , 0 , 0);
          popMatrix();
          }
          if (div == 3){
            pushMatrix();
          translate(x + width * 0.05 - 30, y + height * 0.05 - 20);
          rotate(-PI / 2);
          fill(0);
          text(int(surv) , 0 , 0);
          popMatrix();
          }
        }
        else if (dir.equals("R")) {
          if (div == 1)
        {
          pushMatrix();
          translate(x + width * 0.05 + 20, y + height * 0.05 + 30);
          rotate(PI / 2);
          fill(0);
          text(int(surv) , 0 , 0);
          popMatrix();
        }
        if (div == 2)
        {
          pushMatrix();
          translate(x + width * 0.05 + 30, y + height * 0.05 - 20);
          rotate(-PI / 2);
          fill(0);
          text(int(surv) , 0 , 0);
          popMatrix();
        }
        if (div == 3)
        {
          pushMatrix();
          translate(x + width * 0.05 + 10, y + height * 0.05 + 10);
          rotate(PI / 2);
          fill(0);
          text(int(surv) , 0 , 0);
          popMatrix();
        }
      }
    }/*
    if(prevrow2 == null){
      fill(0);
      textAlign(CENTER);
      String label = "Division " + div + " (" + dir + ")";
      text(label, x + width * 0.05, y + height * 0.05 - 10);
    }*/

}
    prevrow2 = row;
    prevlonp = lonp;
    prevlatp = latp;
    prevdir = dir;
    prevdiv = div;

 }
 for (TableRow row : table.rows()) {
    if(Float.isNaN(row.getFloat("LONC")) || Float.isNaN(row.getFloat("LATC")))
      {break;}
    else
    {
    float lon = row.getFloat("LONC");
    println("lon:",lon);
    float lat = row.getFloat("LATC");
    println("lat:",lat);
    String city = row.getString("CITY");
    println("city:",city);
    // Convert lon/lat to screen coordinates
    float x = map(lon, minLon, maxLon, 0, chartWidth);
    float y = map(lat, minLat, maxLat, chartHeight * 0.7, 0);  // Inverting y to match typical latitude/longitude plot

    // Draw city as a point
    fill(0);
    ellipse(x + width * 0.05, y + height * 0.05, 10, 10);  // Adjust positions
    textAlign(CENTER);
    textSize(20);
    text(city, x + width * 0.05, y + height * 0.05 + 20);  // Label the city
    }
  }
  drawLegend();
   noLoop();
   //endRecord();
}
  void drawLegend() {
  // Legend position
  float legendX = width - 160; // Right position
  float legendY = height / 2 - 70; // Middle position

  // Legend box background
  fill(255); // White background for the legend
  rect(legendX, legendY, 140, 270); // Legend box

  // Title
  fill(0); // Black text
  textSize(14);
  text("Legend", legendX + 70, legendY + 20);
  
  // Colors for direction "A"
  fill(144, 238, 144); // Light green for Division 1, A
  rect(legendX + 10, legendY + 40, 20, 20);
  fill(51, 153, 102); // Dark green for Division 2, A
  rect(legendX + 10, legendY + 70, 20, 20);
  fill(0, 102, 0); // Darker green for Division 3, A
  rect(legendX + 10, legendY + 100, 20, 20);
  
  // Text for direction "A"
  fill(0); // Black text
  text("Attacking Div 1", legendX + 85, legendY + 55);
  text("Attacking Div 2", legendX + 85, legendY + 85);
  text("Attacking Div 3", legendX + 85, legendY + 115);
  
  // Colors for direction "R"
  fill(253, 139, 81); // Light red for Division 1, R
  rect(legendX + 10, legendY + 130, 20, 20);
  fill(203, 96, 64); // Red for Division 2, R
  rect(legendX + 10, legendY + 160, 20, 20);
  fill(139, 0, 0); // Dark red for Division 3, R
  rect(legendX + 10, legendY + 190, 20, 20);

  // Text for direction "R"
  fill(0); // Black text
  text("Returning Div 1", legendX + 85, legendY + 145);
  text("Returning Div 2", legendX + 85, legendY + 175);
  text("Returning Div 3", legendX + 85, legendY + 205);
  text("With Survivor Counts", legendX + 70, legendY + 230);
  
  fill(0);
  ellipse(legendX + 20, legendY + 250, 12, 12);
  text("City Name", legendX + 75, legendY + 255);
}
