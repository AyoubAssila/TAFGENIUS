import React, { useRef, useEffect, useState } from 'react';

const AnalyticsChart = ({ data, type = "bar", title }) => {
  const canvasRef = useRef(null);
  const [animationProgress, setAnimationProgress] = useState(0);

  useEffect(() => {
    const canvas = canvasRef.current;
    if (!canvas) return;
    
    const ctx = canvas.getContext('2d');
    if (!ctx) return;
    
    const animateChart = () => {
      let progress = 0;
      const duration = 1000;
      const startTime = Date.now();

      const animate = () => {
        const currentTime = Date.now();
        progress = Math.min((currentTime - startTime) / duration, 1);
        
        setAnimationProgress(progress);
        
        ctx.clearRect(0, 0, canvas.width, canvas.height);
        
        if (type === "bar") {
          drawBarChart(ctx, data, progress);
        } else if (type === "line") {
          drawLineChart(ctx, data, progress);
        }
        
        if (progress < 1) {
          requestAnimationFrame(animate);
        }
      };
      
      animate();
    };

    animateChart();
  }, [data, type]);

  const drawBarChart = (ctx, data, progress) => {
    if (!data || !data.values || !data.labels) return;
    
    const maxValue = Math.max(...data.values);
    const barWidth = 30;
    const spacing = 15;
    const chartHeight = 120;
    const startY = 150;

    data.labels.forEach((label, index) => {
      const value = data.values[index];
      const animatedValue = value * progress;
      const barHeight = (animatedValue / maxValue) * chartHeight;
      const x = index * (barWidth + spacing) + 40;
      const y = startY - barHeight;

      // Bar with gradient
      const gradient = ctx.createLinearGradient(x, y, x, startY);
      gradient.addColorStop(0, "#2563eb");
      gradient.addColorStop(1, "#1d4ed8");
      
      ctx.fillStyle = gradient;
      ctx.fillRect(x, y, barWidth, barHeight);

      // Value
      ctx.fillStyle = "#1f2937";
      ctx.font = "10px Arial";
      ctx.fillText(Math.round(animatedValue).toString(), x + 5, y - 5);

      // Label
      ctx.fillText(label, x, startY + 15);
    });
  };

  const drawLineChart = (ctx, data, progress) => {
    if (!data || !data.values || !data.labels) return;
    
    const maxValue = Math.max(...data.values);
    const chartHeight = 120;
    const startY = 150;
    const points = data.values.map((value, index) => {
      const animatedValue = value * progress;
      const x = index * 50 + 40;
      const y = startY - (animatedValue / maxValue) * chartHeight;
      return { x, y, value: animatedValue };
    });

    if (points.length > 1) {
      ctx.strokeStyle = "#2563eb";
      ctx.lineWidth = 3;
      ctx.beginPath();
      
      if (points[0]) {
        ctx.moveTo(points[0].x, points[0].y);
        
        const segmentsToDraw = Math.floor((points.length - 1) * progress);
        for (let i = 1; i <= segmentsToDraw; i++) {
          if (points[i]) {
            ctx.lineTo(points[i].x, points[i].y);
          }
        }
        ctx.stroke();
      }
    }

    points.forEach((point, index) => {
      if (point && index <= points.length * progress) {
        ctx.fillStyle = "#2563eb";
        ctx.beginPath();
        ctx.arc(point.x, point.y, 4, 0, 2 * Math.PI);
        ctx.fill();

        // Values
        ctx.fillStyle = "#1f2937";
        ctx.font = "10px Arial";
        ctx.fillText(Math.round(point.value).toString(), point.x - 8, point.y - 8);

        // Labels
        if (data.labels[index]) {
          ctx.fillText(data.labels[index], point.x - 10, startY + 15);
        }
      }
    });
  };

  return (
    <div style={{ position: "relative", margin: "10px" }}>
      <div style={{ fontSize: "14px", fontWeight: "bold", marginBottom: "10px", textAlign: "center" }}>
        {title}
      </div>
      <canvas 
        ref={canvasRef} 
        width={350} 
        height={180}
        style={{ 
          border: "1px solid #e5e7eb", 
          borderRadius: "8px",
          background: "#f8fafc"
        }}
      />
    </div>
  );
};

export default AnalyticsChart;