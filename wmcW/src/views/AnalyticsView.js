import React from 'react';
import AnalyticsChart from '../components/AnalyticsChart';

const styles = {
  contentSection: {
    backgroundColor: "white",
    borderRadius: "16px",
    padding: "25px",
    marginBottom: "30px",
    boxShadow: "0 4px 15px rgba(0,0,0,0.1)",
    border: "1px solid #e2e8f0",
    marginLeft: "280px",
    marginRight: "30px"
  },
  sectionTitle: {
    fontSize: "20px",
    fontWeight: "bold",
    color: "#1e293b",
    marginBottom: "20px"
  },
  statsGrid: {
    display: "grid",
    gridTemplateColumns: "repeat(auto-fit, minmax(250px, 1fr))",
    gap: "20px",
    marginBottom: "30px"
  },
  statCard: {
    backgroundColor: "white",
    padding: "25px",
    borderRadius: "16px",
    boxShadow: "0 4px 15px rgba(0,0,0,0.1)",
    transition: "all 0.3s ease",
    border: "1px solid #e2e8f0",
    textAlign: "center"
  },
  statCardHover: {
    transform: "translateY(-5px)",
    boxShadow: "0 8px 25px rgba(0,0,0,0.15)"
  },
  statValue: {
    fontSize: "32px",
    fontWeight: "bold",
    color: "#1e293b",
    marginBottom: "8px"
  },
  statLabel: {
    color: "#64748b",
    fontSize: "16px",
    fontWeight: "600"
  },
  chartsGrid: {
    display: "grid",
    gridTemplateColumns: "repeat(auto-fit, minmax(400px, 1fr))",
    gap: "30px",
    marginBottom: "30px"
  },
  chartContainer: {
    backgroundColor: "#f8fafc",
    padding: "20px",
    borderRadius: "12px",
    border: "1px solid #e2e8f0"
  },
  metricGrid: {
    display: "grid",
    gridTemplateColumns: "repeat(auto-fit, minmax(200px, 1fr))",
    gap: "20px",
    marginTop: "30px"
  },
  metricCard: {
    backgroundColor: "white",
    padding: "20px",
    borderRadius: "12px",
    textAlign: "center",
    boxShadow: "0 2px 10px rgba(0,0,0,0.1)",
    transition: "all 0.3s ease",
    border: "1px solid #e2e8f0"
  },
  metricCardHover: {
    transform: "translateY(-2px)",
    boxShadow: "0 4px 15px rgba(0,0,0,0.15)"
  },
  metricValue: {
    fontSize: "24px",
    fontWeight: "bold",
    color: "#2563eb",
    marginBottom: "8px"
  },
  metricLabel: {
    color: "#64748b",
    fontSize: "14px",
    fontWeight: "500"
  },
  progressBar: {
    height: "8px",
    backgroundColor: "#e2e8f0",
    borderRadius: "4px",
    marginTop: "10px",
    overflow: "hidden"
  },
  progressFill: {
    height: "100%",
    backgroundColor: "#2563eb",
    borderRadius: "4px",
    transition: "width 0.3s ease"
  },
  analyticsOverview: {
    display: "grid",
    gridTemplateColumns: "2fr 1fr",
    gap: "30px",
    marginBottom: "30px"
  },
  overviewCard: {
    backgroundColor: "#f8fafc",
    padding: "25px",
    borderRadius: "12px",
    border: "1px solid #e2e8f0"
  }
};

export const AnalyticsView = ({ viewModel }) => {
  const [localHovered, setLocalHovered] = React.useState(null);
  
  const stats = viewModel.getStats();

  const performanceMetrics = [
    { value: "87%", label: "Completion Rate", progress: 87, id: 'metric1' },
    { value: "4.8/5", label: "Student Rating", progress: 96, id: 'metric2' },
    { value: "92%", label: "Satisfaction", progress: 92, id: 'metric3' },
    { value: "15min", label: "Avg. Response Time", progress: 85, id: 'metric4' },
    { value: "78%", label: "Engagement Rate", progress: 78, id: 'metric5' },
    { value: "95%", label: "Retention Rate", progress: 95, id: 'metric6' }
  ];

  const additionalCharts = {
    platformUsage: {
      labels: ["Mobile", "Desktop", "Tablet"],
      values: [45, 50, 5]
    },
    contentTypes: {
      labels: ["Videos", "Quizzes", "Readings", "Projects"],
      values: [35, 25, 20, 20]
    }
  };

  return (
    <div style={styles.contentSection}>
      <h3 style={styles.sectionTitle}>Analytics & Statistics</h3>
      
      {/* Main Stats */}
      <div style={styles.statsGrid}>
        {[
          { value: stats.totalStudents, label: "Total Students", id: 'stat1' },
          { value: stats.totalCourses, label: "Courses Created", id: 'stat2' },
          { value: stats.totalThreads, label: "Discussions", id: 'stat3' },
          { value: viewModel.liveSessions.length, label: "Live Sessions", id: 'stat4' },
          { value: stats.totalReplies, label: "Total Replies", id: 'stat5' },
          { value: "98%", label: "Uptime", id: 'stat6' }
        ].map(stat => (
          <div 
            key={stat.id}
            style={{
              ...styles.statCard,
              ...(localHovered === stat.id ? styles.statCardHover : {})
            }}
            onMouseEnter={() => setLocalHovered(stat.id)}
            onMouseLeave={() => setLocalHovered(null)}
          >
            <div style={styles.statValue}>{stat.value}</div>
            <div style={styles.statLabel}>{stat.label}</div>
          </div>
        ))}
      </div>

      {/* Analytics Overview */}
      <div style={styles.analyticsOverview}>
        <div style={styles.overviewCard}>
          <h4 style={{...styles.sectionTitle, fontSize: "18px", marginBottom: "15px"}}>Performance Overview</h4>
          <div style={{ display: "grid", gridTemplateColumns: "repeat(2, 1fr)", gap: "15px" }}>
            <div>
              <div style={{ fontSize: "14px", color: "#64748b", marginBottom: "5px" }}>Monthly Growth</div>
              <div style={{ fontSize: "20px", fontWeight: "bold", color: "#22c55e" }}>+12.5%</div>
            </div>
            <div>
              <div style={{ fontSize: "14px", color: "#64748b", marginBottom: "5px" }}>Active Users</div>
              <div style={{ fontSize: "20px", fontWeight: "bold", color: "#2563eb" }}>1,234</div>
            </div>
            <div>
              <div style={{ fontSize: "14px", color: "#64748b", marginBottom: "5px" }}>Avg. Session</div>
              <div style={{ fontSize: "20px", fontWeight: "bold", color: "#f59e0b" }}>24min</div>
            </div>
            <div>
              <div style={{ fontSize: "14px", color: "#64748b", marginBottom: "5px" }}>Completion</div>
              <div style={{ fontSize: "20px", fontWeight: "bold", color: "#8b5cf6" }}>87%</div>
            </div>
          </div>
        </div>
        
        <div style={styles.overviewCard}>
          <h4 style={{...styles.sectionTitle, fontSize: "18px", marginBottom: "15px"}}>Quick Insights</h4>
          <div style={{ fontSize: "14px", color: "#64748b", lineHeight: "1.6" }}>
            <div style={{ display: "flex", alignItems: "center", gap: "8px", marginBottom: "8px" }}>
              <span style={{ color: "#22c55e" }}>✓</span>
              <span>Student engagement is up 15% this month</span>
            </div>
            <div style={{ display: "flex", alignItems: "center", gap: "8px", marginBottom: "8px" }}>
              <span style={{ color: "#f59e0b" }}>⚠</span>
              <span>Course completion rates are stable at 87%</span>
            </div>
            <div style={{ display: "flex", alignItems: "center", gap: "8px" }}>
              <span style={{ color: "#3b82f6" }}>📈</span>
              <span>Live session attendance increased by 25%</span>
            </div>
          </div>
        </div>
      </div>

      {/* Main Charts */}
      <div style={styles.chartsGrid}>
        <div style={styles.chartContainer}>
          <AnalyticsChart 
            data={viewModel.analyticsData.students} 
            type="line" 
            title="Enrollment Growth" 
          />
        </div>
        <div style={styles.chartContainer}>
          <AnalyticsChart 
            data={viewModel.analyticsData.engagement} 
            type="bar" 
            title="Weekly Engagement" 
          />
        </div>
        <div style={styles.chartContainer}>
          <AnalyticsChart 
            data={viewModel.analyticsData.courses} 
            type="bar" 
            title="Course Popularity" 
          />
        </div>
        <div style={styles.chartContainer}>
          <AnalyticsChart 
            data={additionalCharts.platformUsage} 
            type="bar" 
            title="Platform Usage" 
          />
        </div>
      </div>

      {/* Performance Metrics */}
      <div>
        <h4 style={styles.sectionTitle}>Performance Metrics</h4>
        <div style={styles.metricGrid}>
          {performanceMetrics.map(metric => (
            <div 
              key={metric.id}
              style={{
                ...styles.metricCard,
                ...(localHovered === metric.id ? styles.metricCardHover : {})
              }}
              onMouseEnter={() => setLocalHovered(metric.id)}
              onMouseLeave={() => setLocalHovered(null)}
            >
              <div style={styles.metricValue}>{metric.value}</div>
              <div style={styles.metricLabel}>{metric.label}</div>
              <div style={styles.progressBar}>
                <div 
                  style={{
                    ...styles.progressFill,
                    width: `${metric.progress}%`
                  }} 
                />
              </div>
            </div>
          ))}
        </div>
      </div>

      {/* Additional Insights */}
      <div style={{ marginTop: "30px", padding: "20px", backgroundColor: "#f0f9ff", borderRadius: "12px", border: "1px solid #bae6fd" }}>
        <h4 style={{...styles.sectionTitle, color: "#0369a1", marginBottom: "15px"}}>Insights & Recommendations</h4>
        <div style={{ display: "grid", gridTemplateColumns: "repeat(auto-fit, minmax(300px, 1fr))", gap: "20px" }}>
          <div>
            <h5 style={{ color: "#0369a1", marginBottom: "10px" }}>Top Performing</h5>
            <ul style={{ color: "#64748b", fontSize: "14px", lineHeight: "1.6" }}>
              <li>Python courses have highest completion rate (94%)</li>
              <li>Live Q&A sessions show 78% attendance</li>
              <li>Forum engagement increased by 32% this month</li>
            </ul>
          </div>
          <div>
            <h5 style={{ color: "#dc2626", marginBottom: "10px" }}>Areas for Improvement</h5>
            <ul style={{ color: "#64748b", fontSize: "14px", lineHeight: "1.6" }}>
              <li>Advanced courses have lower completion rates</li>
              <li>Weekend engagement drops by 45%</li>
              <li>Mobile app usage lower than desktop</li>
            </ul>
          </div>
        </div>
      </div>
    </div>
  );
};