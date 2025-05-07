package com.example.todaysfortune

import android.content.Intent
import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.text.BasicText
import androidx.compose.material3.Button
import androidx.compose.material3.ButtonDefaults
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.res.colorResource
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import com.example.todaysfortune.ui.theme.TodaysFortuneTheme

class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            TodaysFortuneTheme {
                MainScreen()
            }
        }
    }
}

@Composable
fun MainScreen() {
    val context = LocalContext.current

    Box(
        modifier = Modifier
            .fillMaxSize()
            .padding(16.dp),
        contentAlignment = Alignment.Center
    ) {
        Column(
            horizontalAlignment = Alignment.CenterHorizontally,
            verticalArrangement = Arrangement.Center
        ) {
            Text(
                text = "☁️",
                style = androidx.compose.ui.text.TextStyle(
                    fontSize = 64.sp
                )
            )
            Spacer(modifier = Modifier.height(16.dp))
            Text(
                text = "Today's Fortune",
                style = androidx.compose.ui.text.TextStyle(
                    color = Color(0xFF89CFF0),
                    fontSize = 32.sp,
                    fontWeight = androidx.compose.ui.text.font.FontWeight.Bold
                )
            )
            Spacer(modifier = Modifier.height(24.dp))
            Text(
                text = "What will today bring?",
                style = androidx.compose.ui.text.TextStyle(
                    color = Color.Gray,
                    fontSize = 18.sp
                ),
            )
            Spacer(modifier = Modifier.height(8.dp))
            Text(
                text = "Check your fortune! 😶‍🌫️",
                style = androidx.compose.ui.text.TextStyle(
                    color = Color.Gray,
                    fontSize = 18.sp
                ),
            )
            Spacer(modifier = Modifier.height(24.dp))
            Button(
                onClick = {
                    val intent = Intent(context, LoadingActivity::class.java)
                    context.startActivity(intent)
                },
                modifier = Modifier
                    .fillMaxWidth()
                    .height(50.dp),
                colors = ButtonDefaults.buttonColors(
                    containerColor = Color(0xFF89CFF0)
                ),
            ) {
                Text(text = "Check Your Fortune", color = Color.White)
            }
        }
    }
}

@Preview(showBackground = true)
@Composable
fun MainScreenPreview() {
    TodaysFortuneTheme {
        MainScreen()
    }
}
