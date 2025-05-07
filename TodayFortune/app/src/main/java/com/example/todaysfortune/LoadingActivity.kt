package com.example.todaysfortune

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.layout.*
import androidx.compose.material3.CircularProgressIndicator
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.compose.runtime.LaunchedEffect
import kotlinx.coroutines.delay
import android.content.Intent
import androidx.compose.ui.platform.LocalContext
import com.example.todaysfortune.ui.theme.TodaysFortuneTheme


class LoadingActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            TodaysFortuneTheme {
                LoadingScreen()
            }
        }
    }
}

@Composable
fun LoadingScreen() {
    val context = LocalContext.current

    LaunchedEffect(Unit) {
        delay(2500) // 2.5초 대기
        context.startActivity(Intent(context, ResultActivity::class.java))
    }

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
            CircularProgressIndicator(
                color = Color(0xFF89CFF0),
                strokeWidth = 5.dp
            )
            Spacer(modifier = Modifier.height(16.dp))
            Text(
                text = "Checking your fortune...",
                style = androidx.compose.ui.text.TextStyle(
                    color = Color.Gray,
                    fontSize = 18.sp
                )
            )
            Spacer(modifier = Modifier.height(8.dp))
            Text(
                text = "Please wait!",
                style = androidx.compose.ui.text.TextStyle(
                    color = Color.Gray,
                    fontSize = 18.sp
                )
            )
        }
    }
}

@Preview(showBackground = true)
@Composable
fun LoadingScreenPreview() {
    TodaysFortuneTheme {
        LoadingScreen()
    }
}
